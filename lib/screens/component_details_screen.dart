import 'package:buildmypc/models/case.dart';
import 'package:buildmypc/models/cpu.dart';
import 'package:buildmypc/models/cpu_cooler.dart';
import 'package:buildmypc/models/gpu.dart';
import 'package:buildmypc/models/motherboard.dart';
import 'package:buildmypc/models/psu.dart';
import 'package:buildmypc/models/ram.dart';
import 'package:buildmypc/models/storage.dart';
import 'package:flutter/material.dart';

class ComponentDetailsScreen extends StatelessWidget {
  final dynamic component;

  const ComponentDetailsScreen({Key? key, required this.component})
      : super(key: key);

  String _getComponentDetails() {
    if (component is Cpu) {
      return 'Nome: ${component.name}\n'
          'Socket: ${component.socket}\n'
          'TDP: ${component.tdp}W\n'
          'Prezzo: \$${component.price.toStringAsFixed(2)}';
    } else if (component is Gpu) {
      return 'Nome: ${component.name}\n'
          'Lunghezza: ${component.length}mm\n'
          'Prezzo: \$${component.price.toStringAsFixed(2)}';
    } else if (component is Ram) {
      return 'Nome: ${component.name}\n'
          'Capacità: ${component.capacity}GB\n'
          'Prezzo: \$${component.price.toStringAsFixed(2)}';
    } else if (component is Motherboard) {
      return 'Nome: ${component.name}\n'
          'Socket: ${component.socket}\n'
          'Prezzo: \$${component.price.toStringAsFixed(2)}';
    } else if (component is Storage) {
      return 'Nome: ${component.name}\n'
          'Capacità: ${component.capacity}GB\n'
          'Prezzo: \$${component.price.toStringAsFixed(2)}';
    } else if (component is Psu) {
      return 'Nome: ${component.name}\n'
          'Potenza: ${component.wattage}W\n'
          'Prezzo: \$${component.price.toStringAsFixed(2)}';
    } else if (component is Case) {
      return 'Nome: ${component.name}\n'
          'Form Factor Support: ${component.formFactorSupport.join(', ')}\n'
          'Prezzo: \$${component.price.toStringAsFixed(2)}';
    } else if (component is CpuCooler) {
      return 'Nome: ${component.name}\n'
          'Supporto TDP: ${component.tdpSupport}W\n'
          'Prezzo: \$${component.price.toStringAsFixed(2)}';
    }

    return 'Dettagli non disponibili per questo componente.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(component.name ?? 'Dettagli Componente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dettagli del Componente',
            ),
            const SizedBox(height: 16.0),
            Text(
              _getComponentDetails(),
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
