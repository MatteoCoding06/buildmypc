import 'package:buildmypc/models/case.dart';
import 'package:buildmypc/models/gpu.dart';
import 'package:buildmypc/models/motherboard.dart';
import 'package:buildmypc/models/psu.dart';
import 'package:buildmypc/models/ram.dart';
import 'package:buildmypc/models/storage.dart';
import 'package:buildmypc/services/case_service.dart';
import 'package:buildmypc/services/gpu_service.dart';
import 'package:buildmypc/services/psu_service.dart';
import 'package:buildmypc/services/ram_service.dart';
import 'package:buildmypc/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:buildmypc/services/cpu_service.dart';
import 'package:buildmypc/services/cpu_cooler_service.dart';
import 'package:buildmypc/services/motherboard_service.dart';
import 'package:buildmypc/models/cpu.dart';
import 'package:buildmypc/models/cpu_cooler.dart';

class ConfigurePcBuild extends StatefulWidget {
  const ConfigurePcBuild({super.key});

  @override
  State<ConfigurePcBuild> createState() => _ConfigurePcBuildState();
}

class _ConfigurePcBuildState extends State<ConfigurePcBuild> {
  Cpu? selectedCpu;
  CpuCooler? selectedCooler;
  Motherboard? selectedMotherboard;
  Ram? selectedRam;
  Storage? selectedStorage;
  Gpu? selectedGpu;
  Case? selectedCase;
  Psu? selectedPsu;

  List<Cpu> availableCpus = [];
  List<CpuCooler> availableCoolers = [];
  List<Motherboard> availableMotherboards = []; // Lista per le motherboard
  List<Ram> availableRams = []; // Lista per le RAM
  List<Storage> availableStorage = []; // Lista per i storage
  List<Gpu> availableGpus = []; // Lista per i GPU
  List<Case> availableCases = []; // Lista per i Case
  List<Psu> availablePsus = []; // Lista per i PSU

  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final cpus = await CpuService.fetchCpus();
      final coolers = await CpuCoolerService.fetchCpuCoolers();
      final motherboards = await MotherboardService.fetchMotherboards();
      final rams = await RamService.fetchRams();
      final storages = await StorageService.fetchStorage();
      final gpus = await GpuService.fetchGpus();
      final cases = await CaseService.fetchCases();
      final psus = await PsuService.fetchPSUs();

      setState(() {
        availableCpus = cpus;
        availableCoolers = coolers;
        availableMotherboards = motherboards;
        availableRams = rams;
        availableStorage = storages;
        availableGpus = gpus;
        availableCases = cases;
        availablePsus = psus;
      });
    } catch (e) {
      print("Errore nel recuperare i dati: $e");
    }
  }

  void selectCpu(Cpu cpu) {
    setState(() {
      selectedCpu = cpu;
      selectedCooler = null;
      selectedMotherboard = null;
    });
    calculateTotalPrice();
  }

  void selectCooler(CpuCooler cooler) {
    setState(() {
      selectedCooler = cooler;
    });
    calculateTotalPrice();
  }

  void selectMotherboard(Motherboard motherboard) {
    setState(() {
      selectedMotherboard = motherboard;
      selectedRam = null;
    });
    calculateTotalPrice();
  }

  void selectRam(Ram ram) {
    setState(() {
      selectedRam = ram;
    });
    calculateTotalPrice();
  }

  void selectStorage(Storage storage) {
    setState(() {
      selectedStorage = storage;
    });
    calculateTotalPrice();
  }

  void selectGpu(Gpu gpu) {
    setState(() {
      selectedGpu = gpu;
    });
    calculateTotalPrice();
  }

  void selectCase(Case cases) {
    setState(() {
      selectedCase = cases;
    });
    calculateTotalPrice();
  }

  void selectPsu(Psu psu) {
    setState(() {
      selectedPsu = psu;
    });
    calculateTotalPrice();
  }

  void _deleteCpu() {
    setState(() {
      selectedCpu = null;
      selectedCooler = null;
      selectedMotherboard = null;
    });
    calculateTotalPrice();
  }

  void _deleteCooler() {
    setState(() {
      selectedCooler = null;
    });
    calculateTotalPrice();
  }

  void _deleteMotherboard() {
    setState(() {
      selectedMotherboard = null;
      selectedRam = null;
    });
    calculateTotalPrice();
  }

  void _deleteRam() {
    setState(() {
      selectedRam = null;
    });
    calculateTotalPrice();
  }

  void _deleteStorage() {
    setState(() {
      selectedStorage = null;
    });
    calculateTotalPrice();
  }

  void _deleteGpu() {
    setState(() {
      selectedGpu = null;
    });
    calculateTotalPrice();
  }

  void _deleteCase() {
    setState(() {
      selectedCase = null;
    });
    calculateTotalPrice();
  }

  void _deletePsu() {
    setState(() {
      selectedPsu = null;
    });
    calculateTotalPrice();
  }

  void calculateTotalPrice() {
    totalPrice = 0.0;

    if (selectedCpu != null) totalPrice += selectedCpu!.price;
    if (selectedCooler != null) totalPrice += selectedCooler!.price;
    if (selectedMotherboard != null) totalPrice += selectedMotherboard!.price;
    if (selectedRam != null) totalPrice += selectedRam!.price;
    if (selectedStorage != null) totalPrice += selectedStorage!.price;
    if (selectedGpu != null) totalPrice += selectedGpu!.price;
    if (selectedCase != null) totalPrice += selectedCase!.price;
    if (selectedPsu != null) totalPrice += selectedPsu!.price;

    setState(() {}); // Rende il totale visibile
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configura il tuo PC")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCpuSection(),
              const SizedBox(height: 20),
              _buildCoolerSection(),
              const SizedBox(height: 20),
              _buildMotherboardSection(),
              const SizedBox(height: 20),
              _buildRamSection(),
              const SizedBox(height: 20),
              _buildStorageSection("Storage"),
              const SizedBox(height: 20),
              _buildGpuSection(),
              const SizedBox(height: 20),
              _buildCaseSection(),
              const SizedBox(height: 20),
              _buildPsuSection(),
              const SizedBox(height: 20),
              _buildTotalPriceSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCpuSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("CPU"),
        selectedCpu != null
            ? _buildSelectedCpuCard(selectedCpu!)
            : _buildSelectButton("Scegli una CPU", availableCpus, selectCpu),
      ],
    );
  }

  Widget _buildCoolerSection() {
    final compatibleCoolers = availableCoolers.where((cooler) {
      return selectedCpu == null ||
          cooler.socketSupport.contains(selectedCpu!.socket);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Dissipatore CPU"),
        selectedCooler != null
            ? _buildSelectedCoolerCard(selectedCooler!)
            : _buildSelectButton(
                "Scegli un dissipatore", compatibleCoolers, selectCooler),
      ],
    );
  }

  // Aggiungi la sezione per la motherboard
  Widget _buildMotherboardSection() {
    final compatibleMotherboards = availableMotherboards.where((motherboard) {
      return selectedCpu == null ||
          motherboard.socket ==
              selectedCpu!.socket; // Filtro in base alla socket della CPU
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Scheda Madre"),
        selectedMotherboard != null
            ? _buildSelectedMotherboardCard(selectedMotherboard!)
            : _buildSelectButton("Scegli una Scheda Madre",
                compatibleMotherboards, selectMotherboard),
      ],
    );
  }

  Widget _buildRamSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("RAM"),
        selectedRam != null
            ? _buildSelectedRamCard(selectedRam!)
            : _buildSelectButton("Scegli una RAM", availableRams, selectRam),
      ],
    );
  }

  Widget _buildGpuSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("GPU"),
        selectedGpu != null
            ? _buildSelectedGpuCard(selectedGpu!)
            : _buildSelectButton("Scegli una GPU", availableGpus, selectGpu),
      ],
    );
  }

  Widget _buildCaseSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Case"),
        selectedCase != null
            ? _buildSelectedCaseCard(selectedCase!)
            : _buildSelectButton("Scegli un Case", availableCases, selectCase),
      ],
    );
  }

  Widget _buildPsuSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("PSU"),
        selectedPsu != null
            ? _buildSelectedPsuCard(selectedPsu!)
            : _buildSelectButton("Scegli una PSU", availablePsus, selectPsu),
      ],
    );
  }

  Widget _buildStorageSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Storage"),
        selectedStorage != null
            ? _buildSelectedStorageCard(selectedStorage!)
            : _buildSelectButton(
                "Scegli uno Storage", availableStorage, selectStorage),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Column(
      children: [
        Row(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            const Expanded(child: Divider(color: Colors.black, thickness: 1)),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSelectButton<T>(
      String label, List<T> items, Function(T) onSelect) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: () => _showSelectionDialog(context, items, onSelect),
        icon: const Icon(Icons.add),
        label: Text(label),
        style: FilledButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSelectedCpuCard(Cpu cpu) {
    return _buildSelectedCard(
        cpu.name, "Brand: ${cpu.brand} • Socket: ${cpu.socket}", cpu.price);
  }

  Widget _buildSelectedCoolerCard(CpuCooler cooler) {
    return _buildSelectedCard(
        cooler.name, "Brand: ${cooler.brand} ", cooler.price);
  }

  Widget _buildSelectedRamCard(Ram ram) {
    return _buildSelectedCard(
      ram.name,
      "Brand: ${ram.brand} • Capacity: ${ram.capacity}GB",
      ram.price,
    );
  }

  Widget _buildSelectedStorageCard(Storage storage) {
    return _buildSelectedCard(
      storage.name,
      "Brand: ${storage.brand} • Capacity: ${storage.capacity}GB • Type: ${storage.type}",
      storage.price,
    );
  }

  Widget _buildSelectedGpuCard(Gpu gpu) {
    return _buildSelectedCard(
      gpu.name,
      "Brand: ${gpu.brand} • Length: ${gpu.length}mm",
      gpu.price,
    );
  }

  Widget _buildSelectedCaseCard(Case cases) {
    return _buildSelectedCard(
      cases.name,
      "Brand: ${cases.brand} • Form Factor: ${cases.formFactorSupport.join(', ')}",
      cases.price,
    );
  }

  Widget _buildSelectedPsuCard(Psu psu) {
    return _buildSelectedCard(
      psu.name,
      "Brand: ${psu.brand} • Rating: ${psu.efficiencyRating}",
      psu.price,
    );
  }

  Widget _buildSelectedMotherboardCard(Motherboard motherboard) {
    return _buildSelectedCard(
        motherboard.name,
        "Brand: ${motherboard.brand} • Socket: ${motherboard.socket} • RAM Max: ${motherboard.maxRamCapacity}GB",
        motherboard.price);
  }

  Widget _buildSelectedCard(String title, String subtitle, double price) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle:
            Text(subtitle), // Qui metti le info dettagliate sul componente
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("\$${price.toStringAsFixed(2)}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                if (title == selectedCpu?.name) {
                  _deleteCpu();
                } else if (title == selectedCooler?.name) {
                  _deleteCooler();
                } else if (title == selectedMotherboard?.name) {
                  _deleteMotherboard();
                } else if (title == selectedRam?.name) {
                  _deleteRam();
                } else if (title == selectedStorage?.name) {
                  _deleteStorage();
                } else if (title == selectedGpu?.name) {
                  _deleteGpu();
                } else if (title == selectedCase?.name) {
                  _deleteCase();
                } else if (title == selectedPsu?.name) {
                  _deletePsu();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSelectionDialog<T>(
      BuildContext context, List<T> items, Function(T) onSelect) {
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        // Determina il titolo in base al tipo di oggetto
        if (items.isNotEmpty) {
          if (items[0] is Cpu) {
            title = "Seleziona una CPU";
          } else if (items[0] is CpuCooler) {
            title = "Seleziona un dissipatore";
          } else if (items[0] is Motherboard) {
            title = "Seleziona una Scheda Madre";
          } else if (items[0] is Ram) {
            title = "Seleziona una RAM";
          } else if (items[0] is Gpu) {
            title = "Seleziona una GPU";
          } else if (items[0] is Case) {
            title = "Seleziona una Case";
          } else if (items[0] is Psu) {
            title = "Seleziona una Psu";
          } else if (items[0] is Storage) {
            title = "Seleziona uno Storage";
          }
        }

        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: items.map((item) {
                String itemName = '';
                String itemDetails = '';
                double itemPrice = 0.0;

                if (item is Cpu) {
                  itemName = item.name;
                  itemDetails =
                      "Brand: ${item.brand} • Socket: ${item.socket} • ${item.tdp}W";
                  itemPrice = item.price;
                } else if (item is CpuCooler) {
                  itemName = item.name;
                  itemDetails =
                      "Brand: ${item.brand} • TDP Max: ${item.tdpSupport}W ";
                  itemPrice = item.price;
                } else if (item is Motherboard) {
                  itemName = item.name;
                  itemDetails =
                      "Brand: ${item.brand} • Socket: ${item.socket} • RAM Max: ${item.maxRamCapacity}GB";
                  itemPrice = item.price;
                } else if (item is Ram) {
                  itemName = item.name;
                  itemDetails =
                      "Brand: ${item.brand} • Capacity: ${item.capacity}GB";
                  itemPrice = item.price;
                } else if (item is Gpu) {
                  itemName = item.name;
                  itemDetails =
                      "Brand: ${item.brand} • Lenght: ${item.length}mm • PCI: ${item.pciVersion} • ${item.powerDraw}W";
                  itemPrice = item.price;
                } else if (item is Case) {
                  itemName = item.name;
                  itemDetails =
                      "Brand: ${item.brand} • Form Factor:${item.formFactorSupport} • MAX GPU Lenght: ${item.maxGpuLength}mm • MAX PSU Lenght: ${item.maxPsuLength}mm";
                  itemPrice = item.price;
                } else if (item is Psu) {
                  itemName = item.name;
                  itemDetails =
                      "Brand: ${item.brand} • Efficiency: ${item.efficiencyRating} • Wattage: ${item.wattage}W";
                  itemPrice = item.price;
                } else if (item is Storage) {
                  itemName = item.name;
                  itemDetails =
                      "Brand: ${item.brand} • Capacity: ${item.capacity}GB • Type: ${item.type} • Interface: ${item.interface}";
                  itemPrice = item.price;
                }

                return ListTile(
                  title: Text(itemName),
                  subtitle: Text(itemDetails),
                  trailing: Text("\$${itemPrice.toStringAsFixed(2)}"),
                  onTap: () {
                    onSelect(item);
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTotalPriceSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Totale:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "\$${totalPrice.toStringAsFixed(2)}",
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ],
      ),
    );
  }
}
