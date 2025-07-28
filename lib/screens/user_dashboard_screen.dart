import 'package:flutter/material.dart';
import 'poll_list_screen.dart';
import 'results_screen.dart';


class UserDashboardScreen extends StatefulWidget {
  final String fullName;
  final String idNumber;
  final String county;
  final String constituency;
  final String ward;


  const UserDashboardScreen({
    super.key,
  required this.fullName,
  required this.idNumber,
  required this.county,
  required this.constituency,
  required this.ward,
  });


  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    _UserDashboardHome(),
    ResultsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VoteSecure Dashboard'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Results',
          ),
        ],
      ),
    );
  }
}

class _UserDashboardHome extends StatelessWidget {
  const _UserDashboardHome();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Hello, Voter!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const Text(
          '🔴 Active Polls',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            title: const Text('Political Election'),
            subtitle: const Text('Ends: July 30, 2025'),
            trailing: ElevatedButton(
              child: const Text('Vote'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PollListScreen()),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 24),
        const Text(
          '🟡 Upcoming Polls',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            title: const Text('Institutional Elections'),
            subtitle: const Text('choose your Institution'),
            trailing: const Icon(Icons.lock_clock),
          ),
        ),

        const SizedBox(height: 8),
        Card(
          child: ListTile(
            title: const Text('Organizational Elections'),
            subtitle: const Text('choose your organization'),
            trailing: const Icon(Icons.lock_clock),
          ),
        ),
      ],
    );
  }
}
