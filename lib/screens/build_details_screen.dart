import 'package:buildmypc/models/case.dart';
import 'package:buildmypc/models/cpu.dart';
import 'package:buildmypc/models/cpu_cooler.dart';
import 'package:buildmypc/models/gpu.dart';
import 'package:buildmypc/models/motherboard.dart';
import 'package:buildmypc/models/psu.dart';
import 'package:buildmypc/models/ram.dart';
import 'package:buildmypc/models/storage.dart';
import 'package:buildmypc/screens/component_details_screen.dart';
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
  bool isLoading = true; // Stato di caricamento

  @override
  void initState() {
    super.initState();
    _loadComponentDetails();
  }

  Future<void> _loadComponentDetails() async {
    try {
      selectedCpu = await getCpuById(widget.build.cpuId);
      selectedCooler = await getCoolerById(widget.build.coolerId!);
      selectedMotherboard =
          await getMotherboardById(widget.build.motherboardId);
      selectedRam = await getRamById(widget.build.ramId);
      selectedStorage = await getStorageById(widget.build.storageId);
      selectedGpu = await getGpuById(widget.build.gpuId!);
      selectedCase = await getCaseById(widget.build.caseId);
      selectedPsu = await getPsuById(widget.build.psuId);
    } catch (error) {
      // Gestione degli errori in caso di problemi con le chiamate API
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Errore nel recupero dei dettagli della build")),
      );
    } finally {
      // Aggiorna lo stato per far sapere che il caricamento è finito
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.build.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator()) // Indicatore di caricamento
            : SingleChildScrollView(
                // ScrollView per contenere il contenuto
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow("CPU", selectedCpu),
                    _buildDetailRow("Dissipatore", selectedCooler),
                    _buildDetailRow("Scheda Madre", selectedMotherboard),
                    _buildDetailRow("RAM", selectedRam),
                    _buildDetailRow("Storage", selectedStorage),
                    _buildDetailRow("GPU", selectedGpu),
                    _buildDetailRow("Case", selectedCase),
                    _buildDetailRow("Alimentatore", selectedPsu),
                    const Divider(),
                    Text(
                      "Prezzo Totale: \$${widget.build.totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildDetailRow(String label, dynamic component) {
    return GestureDetector(
      onTap: () {
        if (component != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComponentDetailsScreen(
                component: component,
              ),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            title: Text(label,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle:
                Text(component?.name ?? "N/A"), // Accede al nome dell'oggetto
            trailing: const Icon(Icons.arrow_forward),
          ),
        ),
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
