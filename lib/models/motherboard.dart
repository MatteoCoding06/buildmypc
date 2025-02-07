class Motherboard {
  final int id;
  final String name;
  final String brand;
  final String model;
  final String socket;
  final String formFactor;
  final String ramType;
  final int maxRamCapacity;
  final List<String> storageSupport;
  final int pciSlots;
  final double price;

  Motherboard({
    required this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.socket,
    required this.formFactor,
    required this.ramType,
    required this.maxRamCapacity,
    required this.storageSupport,
    required this.pciSlots,
    required this.price,
  });

  factory Motherboard.fromJson(Map<String, dynamic> json) {
    return Motherboard(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      model: json['model'],
      socket: json['socket'],
      formFactor: json['form_factor'],
      ramType: json['ram_type'],
      maxRamCapacity: json['max_ram_capacity'],
      storageSupport: List<String>.from(json['storage_support']),
      pciSlots: json['pci_slots'],
      price: json['price'].toDouble(),
    );
  }
}
