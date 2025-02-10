import 'package:supabase_flutter/supabase_flutter.dart';

class PcBuild {
  final String id; // UUID della build
  final String userId; // ID dell'utente proprietario
  final String name;
  final String? description;
  final int cpuId;
  final int? coolerId;
  final int motherboardId;
  final int ramId;
  final int storageId;
  final int? gpuId;
  final int caseId;
  final int psuId;
  final double totalPrice;
  final DateTime createdAt;

  PcBuild({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    required this.cpuId,
    this.coolerId,
    required this.motherboardId,
    required this.ramId,
    required this.storageId,
    this.gpuId,
    required this.caseId,
    required this.psuId,
    required this.totalPrice,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'name': name,
        'description': description,
        'cpu_id': cpuId,
        'cooler_id': coolerId,
        'motherboard_id': motherboardId,
        'ram_id': ramId,
        'storage_id': storageId,
        'gpu_id': gpuId,
        'case_id': caseId,
        'psu_id': psuId,
        'total_price': totalPrice,
        'created_at': createdAt.toIso8601String(),
      };

  factory PcBuild.fromJson(Map<String, dynamic> json) => PcBuild(
        id: json['id'],
        userId: json['user_id'],
        name: json['name'],
        description: json['description'],
        cpuId: json['cpu_id'],
        coolerId: json['cooler_id'],
        motherboardId: json['motherboard_id'],
        ramId: json['ram_id'],
        storageId: json['storage_id'],
        gpuId: json['gpu_id'],
        caseId: json['case_id'],
        psuId: json['psu_id'],
        totalPrice: json['total_price'],
        createdAt: DateTime.parse(json['created_at']),
      );
}

class BuildService {
  final SupabaseClient _supabase;

  BuildService(this._supabase);

  // Verifica se l'utente è autenticato
  String _getCurrentUserId() {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    return user.id;
  }

  // Salva una nuova build
  Future<PcBuild> saveBuild(PcBuild build) async {
    try {
      final userId = _getCurrentUserId();

      // Assicurati che la build appartenga all'utente corrente
      if (build.userId != userId) {
        throw Exception('Unauthorized operation');
      }

      final response = await _supabase
          .from('pc_builds')
          .insert(build.toJson())
          .select()
          .single();

      return PcBuild.fromJson(response);
    } catch (e) {
      throw Exception('Failed to save build: $e');
    }
  }

  // Recupera tutte le build dell'utente
  Future<List<PcBuild>> getUserBuilds() async {
    try {
      final userId = _getCurrentUserId();

      final response = await _supabase
          .from('pc_builds')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return (response as List)
          .map((build) => PcBuild.fromJson(build))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch builds: $e');
    }
  }

  // Cancella una build
  Future<void> deleteBuild(String buildId) async {
    try {
      final userId = _getCurrentUserId();

      // Verifica che la build appartenga all'utente prima di eliminarla
      final build =
          await _supabase.from('pc_builds').select().eq('id', buildId).single();

      if (build['user_id'] != userId) {
        throw Exception('Unauthorized operation');
      }

      await _supabase.from('pc_builds').delete().eq('id', buildId);
    } catch (e) {
      throw Exception('Failed to delete build: $e');
    }
  }

  Future<PcBuild> getBuildById(String buildId) async {
    try {
      final response =
          await _supabase.from('pc_builds').select().eq('id', buildId).single();

      return PcBuild.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch build: $e');
    }
  }

  // Aggiorna una build esistente
  Future<PcBuild> updateBuild(PcBuild build) async {
    try {
      final userId = _getCurrentUserId();

      // Verifica che la build appartenga all'utente
      if (build.userId != userId) {
        throw Exception('Unauthorized operation');
      }

      final response = await _supabase
          .from('pc_builds')
          .update(build.toJson())
          .eq('id', build.id)
          .select()
          .single();

      return PcBuild.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update build: $e');
    }
  }
}
