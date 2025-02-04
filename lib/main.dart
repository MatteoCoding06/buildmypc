import 'package:buildmypc/screens/auth_screen.dart';
import 'package:buildmypc/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://jucjweykfjioujyteogw.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp1Y2p3ZXlrZmppb3VqeXRlb2d3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzg1MDUzNTYsImV4cCI6MjA1NDA4MTM1Nn0.uHk7KAFpeuPMJ1SMxXpqnrram_Fsfy9TX2Fv1tcqhpA",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BuildMyPC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session;

        if (session == null) {
          return const AuthScreen(); // Utente non loggato
        } else {
          return const MainScreen(); // Utente loggato
        }
      },
    );
  }
}
