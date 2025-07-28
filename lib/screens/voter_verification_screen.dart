import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';


class VoterVerificationScreen extends StatefulWidget {
  const VoterVerificationScreen({super.key});

  @override
  State<VoterVerificationScreen> createState() => _VoterVerificationScreenState();
}

class _VoterVerificationScreenState extends State<VoterVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _residenceController = TextEditingController();
  final TextEditingController _wardController = TextEditingController();

  XFile? _idFront;
  XFile? _idBack;
  XFile? _votersCard;

  final ImagePicker _picker = ImagePicker();

  Future<void> _requestPermissions() async {
    await Permission.camera.request();
    await Permission.photos.request();
    await Permission.storage.request();
  }

  Future<void> _pickImage(Function(XFile) onImagePicked) async {
    await _requestPermissions();

    if (await Permission.camera.isGranted || await Permission.photos.isGranted || await Permission.storage.isGranted) {
      final source = await showModalBottomSheet<ImageSource>(
        context: context,
        builder: (context) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
            ],
          ),
        ),
      );

      if (source != null) {
        final XFile? image = await _picker.pickImage(source: source);
        if (image != null) {
          onImagePicked(image);
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Permissions not granted")),
      );
    }
  }

  void _submitVerification() {
    if (_formKey.currentState!.validate() && _idFront != null && _idBack != null && _votersCard != null) {
      // Submit logic or navigate to voting positions screen
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification submitted. Proceeding to vote...')),
      );

      // Example: Navigator.push(... to VoteSelectionScreen with details ...);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields and upload required documents.')),
      );
    }
  }

  Widget _buildUploadCard(String label, XFile? file, VoidCallback onTap) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.image),
        title: Text(file == null ? 'Upload $label' : '$label Uploaded'),
        trailing: IconButton(
          icon: const Icon(Icons.upload_file),
          onPressed: onTap,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voter Verification')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Enter Your Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) => value == null || value.isEmpty ? 'Enter your name' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'National ID Number'),
                validator: (value) => value == null || value.isEmpty ? 'Enter your ID number' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _residenceController,
                decoration: const InputDecoration(labelText: 'County'),
                validator: (value) => value == null || value.isEmpty ? 'Enter your county' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _wardController,
                decoration: const InputDecoration(labelText: 'Constituency / Ward'),
                validator: (value) => value == null || value.isEmpty ? 'Enter your ward' : null,
              ),
              const SizedBox(height: 20),
              const Text('Upload Required Documents', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              _buildUploadCard('ID Front', _idFront, () => _pickImage((img) => setState(() => _idFront = img))),
              _buildUploadCard('ID Back', _idBack, () => _pickImage((img) => setState(() => _idBack = img))),
              _buildUploadCard('Voter\'s Card', _votersCard, () => _pickImage((img) => setState(() => _votersCard = img))),
                  const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _submitVerification,
                  child: const Text('Submit & Continue to Vote'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
