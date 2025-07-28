import 'package:flutter/material.dart';

class VoteConfirmationScreen extends StatelessWidget {
  final String pollTitle;
  final String votedFor;
  final Map<String, int> results; // Simulated results

  const VoteConfirmationScreen({
    super.key,
    required this.pollTitle,
    required this.votedFor,
    required this.results,
  });

  int get totalVotes => results.values.fold(0, (a, b) => a + b);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Vote Submitted')
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 16),
              Text(
                'Thank you for voting!',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'You voted for: $votedFor',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              Text(
                'Live Results',
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,
              ),
              const SizedBox(height: 12),
              Text(
                'Poll Results for "$pollTitle":',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...results.entries.map((entry)  {
                final percent = totalVotes > 0
                    ? (entry.value / totalVotes) * 100
                    : 0.0;


              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${entry.key} - ${percent.toStringAsFixed(1)}% (${entry.value} votes)'),
                  LinearProgressIndicator(
                    value: percent / 100,
                    minHeight: 8,
                    color: entry.key == votedFor ? Colors.blue : Colors.grey,
                  ),
                  const SizedBox(height: 12),
                ],
              );
            }).toList(),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
                },
              icon: const Icon(Icons.home),
              label: const Text('Back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
