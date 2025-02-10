import 'package:buildmypc/models/case.dart';
import 'package:buildmypc/models/cpu.dart';
import 'package:buildmypc/models/cpu_cooler.dart';
import 'package:buildmypc/models/gpu.dart';
import 'package:buildmypc/models/motherboard.dart';
import 'package:buildmypc/models/psu.dart';
import 'package:buildmypc/models/ram.dart';
import 'package:buildmypc/models/storage.dart';
import 'package:buildmypc/services/auth_service.dart';
import 'package:buildmypc/services/pc_build_service.dart';
import 'package:flutter/material.dart';

class BuildDetailPage extends StatefulWidget {
  final PcBuild build; // La build selezionata

  const BuildDetailPage({Key? key, required this.build}) : super(key: key);

  @override
  _BuildDetailPageState createState() => _BuildDetailPageState();
}

class _BuildDetailPageState extends State<BuildDetailPage> {
  Cpu? selectedCpu;
  CpuCooler? selectedCooler;
  Motherboard? selectedMotherboard;
  Ram? selectedRam;
  Storage? selectedStorage;
  Gpu? selectedGpu;
  Case? selectedCase;
  Psu? selectedPsu;

  @override
  void initState() {
    super.initState();
    _loadComponentDetails();
  }

  Future<void> _loadComponentDetails() async {
    selectedCpu = await getCpuById(widget.build.cpuId);
    selectedCooler = await getCoolerById(widget.build.coolerId!);
    selectedMotherboard = await getMotherboardById(widget.build.motherboardId);
    selectedRam = await getRamById(widget.build.ramId);
    selectedStorage = await getStorageById(widget.build.storageId);
    selectedGpu = await getGpuById(widget.build.gpuId!);
    selectedCase = await getCaseById(widget.build.caseId);
    selectedPsu = await getPsuById(widget.build.psuId);

    // Aggiorna lo stato dopo aver caricato i componenti
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.build.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("CPU", selectedCpu?.name),
            _buildDetailRow("Dissipatore", selectedCooler?.name),
            _buildDetailRow("Scheda Madre", selectedMotherboard?.name),
            _buildDetailRow("RAM", selectedRam?.name),
            _buildDetailRow("Storage", selectedStorage?.name),
            _buildDetailRow("GPU", selectedGpu?.name),
            _buildDetailRow("Case", selectedCase?.name),
            _buildDetailRow("Alimentatore", selectedPsu?.name),
            const Divider(),
            Text(
              "Prezzo Totale: \$${widget.build.totalPrice.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value ?? "N/A"),
        ],
      ),
    );
  }

// Funzioni per ottenere gli oggetti completi (esempio con CPU)
  Future<Cpu> getCpuById(int cpuId) async {
    final response = await AuthService()
        .supabase
        .from('cpu')
        .select()
        .eq('id', cpuId)
        .single();
    return Cpu.fromJson(response); // Restituisce l'oggetto Cpu completo
  }

  Future<CpuCooler> getCoolerById(int coolerId) async {
    final response = await AuthService()
        .supabase
        .from('cpu_cooler')
        .select()
        .eq('id', coolerId)
        .single();
    return CpuCooler.fromJson(
        response); // Restituisce l'oggetto Cooler completo
  }

  Future<Motherboard> getMotherboardById(int motherboardId) async {
    final response = await AuthService()
        .supabase
        .from('motherboards')
        .select()
        .eq('id', motherboardId)
        .single();
    return Motherboard.fromJson(
        response); // Restituisce l'oggetto Motherboard completo
  }

  Future<Ram> getRamById(int ramId) async {
    final response = await AuthService()
        .supabase
        .from('ram')
        .select()
        .eq('id', ramId)
        .single();
    return Ram.fromJson(response); // Restituisce l'oggetto Ram completo
  }

  Future<Storage> getStorageById(int storageId) async {
    final response = await AuthService()
        .supabase
        .from('storage')
        .select()
        .eq('id', storageId)
        .single();
    return Storage.fromJson(response); // Restituisce l'oggetto Storage completo
  }

  Future<Gpu> getGpuById(int gpuId) async {
    final response = await AuthService()
        .supabase
        .from('gpu')
        .select()
        .eq('id', gpuId)
        .single();
    return Gpu.fromJson(response); // Restituisce l'oggetto GPU completo
  }

  Future<Case> getCaseById(int caseId) async {
    final response = await AuthService()
        .supabase
        .from('cases')
        .select()
        .eq('id', caseId)
        .single();
    return Case.fromJson(response); // Restituisce l'oggetto Case completo
  }

  Future<Psu> getPsuById(int psuId) async {
    final response = await AuthService()
        .supabase
        .from('psu')
        .select()
        .eq('id', psuId)
        .single();
    return Psu.fromJson(response); // Restituisce l'oggetto PSU completo
  }
}
