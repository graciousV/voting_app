import 'package:flutter/material.dart';
import 'dart:async';
import 'package:voting_app/models/candidate.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  List<Candidate> candidates = [
    Candidate(name: 'Alice', votes: 0),
    Candidate(name: 'Bob', votes: 0),
    Candidate(name: 'Charlie', votes: 0),
  ];

  bool countingDone = false;

  @override
  void initState() {
    super.initState();
    simulateCounting(); // Simulates incoming results
  }

  void simulateCounting() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (candidates.every((c) => c.votes >= 100)) {
        timer.cancel();
        setState(() {
          countingDone = true;
        });
      } else {
        setState(() {
          candidates = candidates.map((c) {
            int newVotes = c.votes + (1 + (10 * (0.5 - (c.votes % 3) * 0.1)).toInt());
            return Candidate(name: c.name, votes: newVotes.clamp(0, 100));
          }).toList();
        });
      }
    });
  }

  Candidate getWinner() {
    candidates.sort((a, b) => b.votes.compareTo(a.votes));
    return candidates.first;
  }

  @override
  Widget build(BuildContext context) {
    int totalVotes = candidates.fold(0, (sum, c) => sum + c.votes);

    return Scaffold(
      appBar: AppBar(title: const Text('Live Election Results')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Real-Time Vote Count',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...candidates.map((c) {
              double percent = totalVotes == 0 ? 0 : c.votes / totalVotes;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${c.name} - ${c.votes} votes'),
                  LinearProgressIndicator(
                    value: percent,
                    minHeight: 10,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 12),
                ],
              );
            }).toList(),
            const Spacer(),
            if (countingDone) ...[
              Text(
                '🟢 Winner: ${getWinner().name} 🎉',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
              ),
              const SizedBox(height: 20),
            ]
          ],
        ),
      ),
    );
  }
}
