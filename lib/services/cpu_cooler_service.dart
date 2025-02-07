import 'package:buildmypc/services/auth_service.dart';
import 'package:buildmypc/models/cpu_cooler.dart';

class CpuCoolerService {
  static Future<List<CpuCooler>> fetchCpuCoolers() async {
    // Esegui la query al database
    final response =
        await AuthService().supabase.from('cpu_cooler').select().execute();

    // Ottieni i dati dalla risposta
    final List<dynamic> data = response.data;

    // Mappa i dati in una lista di oggetti CpuCooler
    return data.map((cooler) => CpuCooler.fromJson(cooler)).toList();
  }
}
