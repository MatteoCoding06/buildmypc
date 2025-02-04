import 'package:flutter/material.dart';
import 'package:buildmypc/services/cpu_service.dart';
import 'package:buildmypc/models/cpu.dart';

class ConfigurePcBuild extends StatefulWidget {
  const ConfigurePcBuild({super.key});

  @override
  State<ConfigurePcBuild> createState() => _ConfigurePcBuildState();
}

class _ConfigurePcBuildState extends State<ConfigurePcBuild> {
  Cpu? selectedCpu;
  List<Cpu> availableCpus = [];

  @override
  void initState() {
    super.initState();
    fetchCpus();
  }

  Future<void> fetchCpus() async {
    try {
      final cpus = await CpuService.fetchCpus();
      if (cpus.isNotEmpty) {
        setState(() {
          availableCpus = cpus;
        });
      } else {
        // Mostra un messaggio che avverte l'utente che non ci sono CPU disponibili
        print("Nessuna CPU disponibile");
      }
    } catch (e) {
      print("Errore nel recuperare le CPU: $e");
    }
  }

  void selectCpu(Cpu cpu) {
    setState(() {
      selectedCpu = cpu;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configura PC")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSection("CPU", "Scegli una CPU", availableCpus, selectCpu),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String buttonText, List<Cpu> items,
      Function(Cpu) onSelect) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              const Expanded(child: Divider(color: Colors.black, thickness: 1)),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => _showSelectionDialog(context, items, onSelect),
              icon: const Icon(Icons.add),
              label: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }

  void _showSelectionDialog(
      BuildContext context, List<Cpu> items, Function(Cpu) onSelect) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Seleziona una CPU"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: items.map((cpu) {
              return ListTile(
                title: Text(cpu.name),
                subtitle: Text("Socket: ${cpu.socket} - ${cpu.tdp}W"),
                onTap: () {
                  onSelect(cpu);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
