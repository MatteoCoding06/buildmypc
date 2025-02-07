import 'package:buildmypc/services/auth_service.dart';
import 'package:buildmypc/models/ram.dart'; // Importa il modello Ram

class RamService {
  static Future<List<Ram>> fetchRams() async {
    try {
      // Esegui la query al database per recuperare i dati delle RAM
      final response =
          await AuthService().supabase.from('ram').select().execute();

      // Se i dati sono presenti, mappali nel modello Ram
      final List<dynamic> data = response.data ?? [];
      return data.map((ram) => Ram.fromJson(ram)).toList();
    } catch (e) {
      // Gestione degli errori
      print('Errore durante il recupero delle RAM: $e');
      return []; // Restituisce una lista vuota in caso di errore
    }
  }
}
