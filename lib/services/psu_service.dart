import 'package:buildmypc/services/auth_service.dart';
import 'package:buildmypc/models/psu.dart';

class PsuService {
  static Future<List<Psu>> fetchPSUs() async {
    final response =
        await AuthService().supabase.from('psu').select().execute();

    final List<dynamic> data = response.data;
    return data.map((item) => Psu.fromJson(item)).toList();
  }
}
