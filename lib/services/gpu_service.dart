import 'package:buildmypc/services/auth_service.dart';
import 'package:buildmypc/models/gpu.dart';

class GpuService {
  static Future<List<Gpu>> fetchGpus() async {
    final response =
        await AuthService().supabase.from('gpu').select().execute();

    final List<dynamic> data = response.data;
    return data.map((gpu) => Gpu.fromJson(gpu)).toList();
  }
}
