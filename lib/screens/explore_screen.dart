import 'package:buildmypc/models/case.dart';
import 'package:buildmypc/models/cpu.dart';
import 'package:buildmypc/models/cpu_cooler.dart';
import 'package:buildmypc/models/gpu.dart';
import 'package:buildmypc/models/motherboard.dart';
import 'package:buildmypc/models/psu.dart';
import 'package:buildmypc/models/ram.dart';
import 'package:buildmypc/models/storage.dart';
import 'package:buildmypc/screens/build_details_screen.dart';
import 'package:buildmypc/screens/component_details_screen.dart';
import 'package:buildmypc/services/auth_service.dart';
import 'package:buildmypc/services/pc_build_service.dart';
import 'package:buildmypc/services/cpu_service.dart';
import 'package:buildmypc/services/gpu_service.dart';
import 'package:buildmypc/services/ram_service.dart';
import 'package:buildmypc/services/motherboard_service.dart';
import 'package:buildmypc/services/storage_service.dart';
import 'package:buildmypc/services/psu_service.dart';
import 'package:buildmypc/services/case_service.dart';
import 'package:buildmypc/services/cpu_cooler_service.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  List<PcBuild> publicBuilds = [];
  Set<String> selectedFilters = {'All'};
  Map<String, List<dynamic>> components = {
    'All': [],
    'CPU': [],
    'GPU': [],
    'RAM': [],
    'Motherboard': [],
    'Storage': [],
    'PSU': [],
    'Case': [],
    'Cooler': [],
  };
  bool isLoading = false;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadPublicBuilds();

    // Carica i componenti inizialmente per il filtro "All"
    _loadComponents(components.keys.where((k) => k != 'All').toList());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadPublicBuilds() async {
    try {
      final builds =
          await BuildService(AuthService().supabase).getPublicBuilds();
      if (mounted) {
        setState(() {
          publicBuilds = builds;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _loadComponents(List<String> types) async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }

    try {
      for (String type in types) {
        if (components[type]!.isEmpty) {
          switch (type) {
            case 'CPU':
              components[type] = await CpuService.fetchCpus();
              break;
            case 'GPU':
              components[type] = await GpuService.fetchGpus();
              break;
            case 'RAM':
              components[type] = await RamService.fetchRams();
              break;
            case 'Motherboard':
              components[type] = await MotherboardService.fetchMotherboards();
              break;
            case 'Storage':
              components[type] = await StorageService.fetchStorage();
              break;
            case 'PSU':
              components[type] = await PsuService.fetchPSUs();
              break;
            case 'Case':
              components[type] = await CaseService.fetchCases();
              break;
            case 'Cooler':
              components[type] = await CpuCoolerService.fetchCpuCoolers();
              break;
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore nel caricamento dei componenti: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _toggleFilter(String filter) async {
    setState(() {
      if (filter == 'All') {
        selectedFilters = {'All'};
      } else {
        selectedFilters.remove('All');
        if (selectedFilters.contains(filter)) {
          selectedFilters.remove(filter);
          if (selectedFilters.isEmpty) {
            selectedFilters.add('All');
          }
        } else {
          selectedFilters.add(filter);
        }
      }
    });

    // Carica i componenti per i filtri selezionati
    if (selectedFilters.contains('All')) {
      await _loadComponents(components.keys.where((k) => k != 'All').toList());
    } else {
      await _loadComponents(selectedFilters.toList());
    }
  }

  List<dynamic> getFilteredComponents() {
    if (selectedFilters.contains('All')) {
      return components.entries
          .where((entry) => entry.key != 'All')
          .expand((entry) => entry.value)
          .toList();
    }
    return selectedFilters
        .expand((filter) => components[filter] ?? [])
        .toList();
  }

  Widget _buildComponentTile(dynamic component) {
    String title = '';
    String subtitle = '';

    if (component is Cpu) {
      title = component.name;
      subtitle =
          '${component.socket} - ${component.tdp}W - \$${component.price.toStringAsFixed(2)}';
    } else if (component is Gpu) {
      title = component.name;
      subtitle =
          '${component.length}mm - \$${component.price.toStringAsFixed(2)}';
    } else if (component is Ram) {
      title = component.name;
      subtitle =
          '${component.capacity}GB - \$${component.price.toStringAsFixed(2)}';
    } else if (component is Motherboard) {
      title = component.name;
      subtitle =
          '${component.socket} socket - \$${component.price.toStringAsFixed(2)}';
    } else if (component is Storage) {
      title = component.name;
      subtitle =
          '${component.capacity}GB - \$${component.price.toStringAsFixed(2)}';
    } else if (component is Psu) {
      title = component.name;
      subtitle =
          '${component.wattage}W - \$${component.price.toStringAsFixed(2)}';
    } else if (component is Case) {
      title = component.name;
      subtitle =
          '${component.formFactorSupport.join(', ')} - \$${component.price.toStringAsFixed(2)}';
    } else if (component is CpuCooler) {
      title = component.name;
      subtitle =
          '${component.tdpSupport}W - \$${component.price.toStringAsFixed(2)}';
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComponentDetailsScreen(component: component),
          ),
        );
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
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: Icon(
              Icons.arrow_forward,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.purple,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.purple,
          tabs: const [
            Tab(text: "Configurazioni"),
            Tab(text: "Componenti"),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Prima tab - Configurazioni
              ListView.builder(
                itemCount: publicBuilds.length,
                itemBuilder: (context, index) {
                  final build = publicBuilds[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.white,
                      child: ListTile(
                        title: Text(build.name),
                        subtitle:
                            Text("\$${build.totalPrice.toStringAsFixed(2)}"),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BuildDetailPage(build: build),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              // Seconda tab - Componenti con filtri
              Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: components.keys.map((filter) {
                        final isSelected = selectedFilters.contains(filter);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: FilterChip(
                            selected: isSelected,
                            label: Text(filter),
                            onSelected: (_) => _toggleFilter(filter),
                            selectedColor: Colors.purple.withOpacity(0.2),
                            checkmarkColor: Colors.purple,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Expanded(
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: getFilteredComponents().length,
                            itemBuilder: (context, index) {
                              final component = getFilteredComponents()[index];
                              return _buildComponentTile(component);
                            },
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
