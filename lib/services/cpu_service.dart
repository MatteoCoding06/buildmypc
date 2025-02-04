import 'package:buildmypc/services/auth_service.dart';
import 'package:buildmypc/models/cpu.dart';

class CpuService {
  static Future<List<Cpu>> fetchCpus() async {
    // Esegui la query al database
    final response =
        await AuthService().supabase.from('cpu').select().execute();

    // Restituisci i dati mappati in una lista di oggetti Cpu
    final List<dynamic> data = response.data; // Ottieni i dati dalla risposta
    return data
        .map((cpu) => Cpu.fromJson(cpu))
        .toList(); // Mappa i dati nel modello Cpu
  }
}
