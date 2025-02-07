import 'package:buildmypc/services/auth_service.dart';
import 'package:buildmypc/models/case.dart';

class CaseService {
  static Future<List<Case>> fetchCases() async {
    final response =
        await AuthService().supabase.from('cases').select().execute();

    final List<dynamic> data = response.data;
    return data.map((item) => Case.fromJson(item)).toList();
  }
}
