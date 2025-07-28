import 'package:flutter/material.dart';
import 'package:voting_app/screens/admin_dashboard_screen.dart';
import 'package:voting_app/screens/results_screen.dart';
import 'package:voting_app/screens/user_dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'screens/create_poll_screen.dart';
import 'screens/poll_list_screen.dart';
import 'screens/vote_screen.dart';
import 'screens/vote_confirmation_screen.dart';


void main() {
  runApp(const VotingApp());
}

class VotingApp extends StatelessWidget {
  const VotingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VoteSecure',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/admin_dashboard': (context) => const AdminDashboardScreen(),
        '/create_poll': (context) => const CreatePollScreen(),
        '/user_dashboard': (context) => const UserDashboardScreen(fullName: '', idNumber: '', county: '', constituency: '', ward: '',),
        '/poll_list': (context) => const PollListScreen(),
        '/vote': (context) => const VoteScreen(pollTitle: '',),
        '/vote_confirmation': (context) => const VoteConfirmationScreen(pollTitle: '', votedFor: '', results: {},),
        '/results_screen': (context) => const ResultsScreen(),
      },
    );
  }
}
