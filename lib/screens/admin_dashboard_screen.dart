import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Admin!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Create Poll
            AdminCard(
              icon: Icons.add_circle_outline,
              title: 'Create Poll',
              onTap: () => Navigator.pushNamed(context, '/create_poll'),
            ),

            // View All Polls
            AdminCard(
              icon: Icons.poll,
              title: 'View Polls',
              onTap: () => Navigator.pushNamed(context, '/poll_list'),
            ),

            // View Results (can be same as polls for now)
            AdminCard(
              icon: Icons.bar_chart,
              title: 'View Results',
              onTap: () {
                // Can reuse poll list or separate results screen
                Navigator.pushNamed(context, '/poll_list');
              },
            ),

            // Optional: User Management
            // AdminCard(
            //   icon: Icons.group,
            //   title: 'Manage Users',
            //   onTap: () {
            //     // Navigate to user list screen (if implemented)
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

class AdminCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const AdminCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, size: 30, color: Colors.deepPurple),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
