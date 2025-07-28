import 'package:flutter/material.dart';
import 'package:voting_app/screens/user_dashboard_screen.dart';

class LocationSelectionScreen extends StatefulWidget {
  final String fullName;
  final String idNumber;

  const LocationSelectionScreen({
    super.key,
    required this.fullName,
    required this.idNumber,
  });

  @override
  _LocationSelectionScreenState createState() =>
      _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  String? selectedCounty;
  String? selectedConstituency;
  String? selectedWard;

  // Sample data – You can replace these with full JSON/map later
  final Map<String, List<String>> counties = {
    'Nairobi': ['Westlands', 'Langata', 'Kasarani'],
    'Kiambu': ['Ruiru', 'Thika', 'Gatundu'],
    'Mombasa': ['Kisauni', 'Likoni', 'Changamwe'],
  };

  final Map<String, List<String>> wards = {
    'Westlands': ['Parklands', 'Kangemi'],
    'Langata': ['South C', 'Karen'],
    'Kasarani': ['Mwiki', 'Clay City'],
    'Ruiru': ['Githurai', 'Membley'],
    'Thika': ['Township', 'Hospital'],
    'Gatundu': ['North', 'South'],
    'Kisauni': ['Bamburi', 'Mtopanga'],
    'Likoni': ['Mtongwe', 'Shika Adabu'],
    'Changamwe': ['Port Reitz', 'Chaani'],
  };

  List<String> getConstituencies() =>
      selectedCounty != null ? counties[selectedCounty!] ?? [] : [];

  List<String> getWards() =>
      selectedConstituency != null ? wards[selectedConstituency!] ?? [] : [];

  void _goToDashboard() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => UserDashboardScreen(
          fullName: widget.fullName,
          idNumber: widget.idNumber,
          county: selectedCounty!,
          constituency: selectedConstituency!,
          ward: selectedWard!,
        ),
      ),
    );
  }

  Widget _buildDropdownCard({
    required String label,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
          ),
          value: value,
          items: items
              .map((e) =>
              DropdownMenuItem(value: e, child: Text(e.toUpperCase())))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Voting Location')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildDropdownCard(
            label: 'County',
            value: selectedCounty,
            items: counties.keys.toList(),
            onChanged: (value) {
              setState(() {
                selectedCounty = value;
                selectedConstituency = null;
                selectedWard = null;
              });
            },
          ),
          if (selectedCounty != null)
            _buildDropdownCard(
              label: 'Constituency',
              value: selectedConstituency,
              items: getConstituencies(),
              onChanged: (value) {
                setState(() {
                  selectedConstituency = value;
                  selectedWard = null;
                });
              },
            ),
          if (selectedConstituency != null)
            _buildDropdownCard(
              label: 'Ward',
              value: selectedWard,
              items: getWards(),
              onChanged: (value) => setState(() => selectedWard = value),
            ),
          const SizedBox(height: 30),
          if (selectedWard != null)
            ElevatedButton.icon(
              onPressed: _goToDashboard,
              icon: const Icon(Icons.check),
              label: const Text('Continue to Dashboard'),
            ),
        ],
      ),
    );
  }
}
