import 'package:flutter/material.dart';
import 'package:voting_app/screens/vote_screen.dart';

class PollListScreen extends StatelessWidget {
  const PollListScreen({super.key});

  final List<Map<String, dynamic>> polls = const [
    {
      'title': 'President Election',
      'status': 'ongoing',
      'ends': '6.00 PM',
    },
    {
      'title': 'Member of Parliament(MP) Election',
      'status': 'ongoing',
      'ends': '6.00 PM',
    },
    {
      'title': 'Senator',
      'status': 'ongoing',
      'ends': '6.00 PM',
    },
    {
      'title': 'Women Representative Elections',
      'status': 'ongoing',
      'ends': '6.00 PM',
    },
    {
      'title': 'Governor Elections',
      'status': 'ongoing',
      'ends': '6.00 PM',
    },
    {
      'title': 'Member of County Assembly(MCA)',
      'status': 'ongoing',
      'ends': '6.00 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poll List'),
      ),
      body: ListView.builder(
        itemCount: polls.length,
        itemBuilder: (context, index) {
          final poll = polls[index];
          Color badgeColor;
          String statusText;

          switch (poll['status']) {
            case 'ongoing':
              badgeColor = Colors.green;
              statusText = 'Ends: ${poll['ends']}';
              break;
            case 'upcoming':
              badgeColor = Colors.orange;
              statusText = 'Starts: ${poll['starts']}';
              break;
            case 'closed':
              badgeColor = Colors.red;
              statusText = 'Ended: ${poll['ended']}';
              break;
            default:
              badgeColor = Colors.grey;
              statusText = 'Unknown';
          }

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(poll['title']),
              subtitle: Text(statusText),
              leading: CircleAvatar(backgroundColor: badgeColor, radius: 6),
              trailing: ElevatedButton(
                onPressed: poll['status'] == 'ongoing'
                    ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VoteScreen(pollTitle: poll['title']),
                    ),
                  );
                  // Navigate to vote screen
                }
                    : null,
                child: Text(poll['status'] == 'closed' ? 'View Result' : 'Vote'),
              ),
            ),
          );
        },
      ),
    );
  }
}
