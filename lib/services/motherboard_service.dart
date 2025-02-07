import 'package:buildmypc/services/auth_service.dart';
import 'package:buildmypc/models/motherboard.dart';

class MotherboardService {
  static Future<List<Motherboard>> fetchMotherboards() async {
    try {
      // Esegui la query al database
      final response =
          await AuthService().supabase.from('motherboards').select().execute();

      // Se i dati sono presenti, mappali nel modello Motherboard
      final List<dynamic> data = response.data ?? [];
      return data
          .map((motherboard) => Motherboard.fromJson(motherboard))
          .toList();
    } catch (e) {
      // Gestione degli errori
      print('Errore durante il recupero delle motherboard: $e');
      return []; // Restituisce una lista vuota in caso di errore
    }
  }
}
