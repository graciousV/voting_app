import 'package:flutter/material.dart';

class CreatePollScreen extends StatefulWidget {
  const CreatePollScreen({super.key});

  @override
  State<CreatePollScreen> createState() => _CreatePollScreenState();
}

class _CreatePollScreenState extends State<CreatePollScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  List<String> options = [''];
  DateTime selectedDate = DateTime.now();

  void _submitPoll() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // TODO: Save poll to Firebase or backend
      Navigator.pop(context);
    }
  }

  void _addOption() {
    setState(() {
      options.add('');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Poll')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Poll Title'),
                validator: (value) =>
                value!.isEmpty ? 'Title is required' : null,
                onSaved: (value) => title = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) =>
                value!.isEmpty ? 'Description is required' : null,
                onSaved: (value) => description = value!,
              ),
              const SizedBox(height: 12),
              const Text('Options'),
              ...options.asMap().entries.map((entry) {
                final index = entry.key;
                return TextFormField(
                  initialValue: entry.value,
                  decoration:
                  InputDecoration(labelText: 'Option ${index + 1}'),
                  onChanged: (val) => options[index] = val,
                  validator: (val) =>
                  val == null || val.isEmpty ? 'Required' : null,
                );
              }),
              TextButton.icon(
                onPressed: _addOption,
                icon: const Icon(Icons.add),
                label: const Text('Add Option'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('Start Date: '),
                  TextButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setState(() => selectedDate = picked);
                      }
                    },
                    child: Text(
                        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}'),
                  )
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _submitPoll,
                icon: const Icon(Icons.check),
                label: const Text('Create Poll'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
