import 'package:buildmypc/services/auth_service.dart';
import 'package:buildmypc/models/storage.dart';

class StorageService {
  // Recupera una lista di Storage dal database
  static Future<List<Storage>> fetchStorage() async {
    // Esegui la query al database per recuperare gli storage
    final response =
        await AuthService().supabase.from('storage').select().execute();

    // Mappa la risposta in una lista di oggetti Storage
    final List<dynamic> data = response.data;
    return data.map((storage) => Storage.fromJson(storage)).toList();
  }
}
