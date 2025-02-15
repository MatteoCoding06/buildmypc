import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  // REGISTRAZIONE UTENTE
  Future<String?> signUp(String email, String password) async {
    try {
      // ignore: unused_local_variable
      final response =
          await supabase.auth.signUp(email: email, password: password);
      return null; // Nessun errore
    } catch (e) {
      return e.toString();
    }
  }

  // LOGIN UTENTE
  Future<String?> signIn(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(email: email, password: password);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  // LOGOUT
  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  // CONTROLLARE SE L'UTENTE È LOGGATO
  bool isLoggedIn() {
    return supabase.auth.currentUser != null;
  }
}
