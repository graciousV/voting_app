import 'package:flutter/material.dart';
import 'create_poll_screen.dart';

class AdminPanelScreen extends StatelessWidget {
  final List<Map<String, dynamic>> samplePolls = [
    {
      'title': 'Student Council Election',
      'description': 'Vote for your new student leader.',
      'status': 'Active',
      'date': '2025-07-30'
    },
    {
      'title': 'New Cafeteria Menu Poll',
      'description': 'Choose your preferred menu items.',
      'status': 'Upcoming',
      'date': '2025-08-05'
    },
  ];

  AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Panel')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreatePollScreen()),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Create New Poll',
      ),
      body: ListView.builder(
        itemCount: samplePolls.length,
        itemBuilder: (context, index) {
          final poll = samplePolls[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(poll['title']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(poll['description']),
                  const SizedBox(height: 4),
                  Text('Status: ${poll['status']} • Date: ${poll['date']}'),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Navigate to edit poll screen (optional)
                },
              ),
              onTap: () {
                // View details or results (optional)
              },
            ),
          );
        },
      ),
    );
  }
}
