import 'package:flutter/material.dart';
import 'package:voting_app/screens/vote_confirmation_screen.dart';

class VoteScreen extends StatefulWidget {
  final String pollTitle;

  const VoteScreen({super.key, required this.pollTitle});

  @override
  State<VoteScreen> createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  String? selectedCandidate;
  List<Map<String, String>> candidates = [];

  @override
  void initState() {
    super.initState();
    candidates = getCandidates(widget.pollTitle);
  }

  List<Map<String, String>> getCandidates(String pollTitle) {
    switch (pollTitle) {
      case 'President Election':
        return [
          {'name': 'Grace Wanjiru', 'party': 'Democratic Party'},
          {'name': 'John Kiranga', 'party': 'Unity Party'},
          {'name': 'Victor Mwangi', 'party': 'Freedom Alliance Party'},
          {'name': 'Emily Wambui', 'party': 'Development Front Party'},
          {'name': 'Danson Githinji', 'party': 'Green movement Party'},
        ];
      case 'Member of Parliament(MP) Election':
        return [
          {'name': 'Brian Otieno', 'party': 'Unity Party'},
          {'name': 'Emily Njeri', 'party': 'Democratic Party'},
          {'name': 'Victoria Kimani', 'party': 'Development Front Party'},
          {'name': 'Edwin Wanju', 'party': 'Freedom Alliance Party'},
          {'name': 'Innocent Koome', 'party': 'Green movement Party'},
        ];
      case 'Senator':
        return [
          {'name': 'Tom Juma', 'party': 'Green movement Party'},
          {'name': 'Mar Akinyi', 'party': 'Freedom Alliance Party'},
        ];
      case 'Women Representative Elections':
        return [
          {'name': 'Purity Mwikali', 'party': 'Development Front Party'},
          {'name': 'Grace Othiambo', 'party': 'Unity Party'},
          {'name': 'Milka Gatuku', 'party': 'Freedom Alliance Party'},
          {'name': 'Lilian Atieno', 'party': 'Democratic Party'},
        ];
      case 'Governor Elections':
        return [
          {'name': 'Peter Mwangi', 'party': 'Unity Party'},
          {'name': 'Fatma Noor', 'party': 'Green movement Party'},
          {'name': 'Eric Mwendia', 'party': 'Development Front Party'},
        ];
      case 'Member of County Assembly(MCA)':
        return [
          {'name': 'James Kariuki', 'party': 'Freedom Alliance Party'},
          {'name': 'George Kimani', 'party': 'Green movement Party'},
          {'name': 'Nancy Mutua', 'party': 'Democratic Party'},
        ];
      default:
        return [{'name': 'No candidates found', 'party': ''}];
    }
  }


  void _submitVote() {
    if (selectedCandidate != null) {
      // Handle vote logic here
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Vote submitted for $selectedCandidate'),
      ));
      Navigator.pop(context); // Go back to poll list or dashboard
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please select a candidate before submitting.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.pollTitle} - Vote'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select a candidate:', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            ...candidates.map((candidate) {
              return RadioListTile<String>(
                title: Text(candidate['name']!),
                subtitle: Text(candidate['party']!),
                value: candidate['name']!,
                groupValue: selectedCandidate,
                onChanged: (value) {
                  setState(() {
                    selectedCandidate = value;
                  });
                },
              );
            }).toList(),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                child: const Text('Submit Vote'),
                onPressed: () {
                  if (selectedCandidate != null) {
                    final selected = candidates.firstWhere((c) =>
                    c['name'] == selectedCandidate);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            VoteConfirmationScreen(
                              pollTitle: widget.pollTitle,
                              votedFor: selected['name']!,
                              results: {
                                selectedCandidate!: 1,
                              },
                            ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text(
                          'Please select a candidate before submitting.')),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
