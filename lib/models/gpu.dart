class Gpu {
  final int id;
  final String name;
  final String brand;
  final String pciVersion;
  final int length;
  final int powerDraw;
  final double price;

  Gpu({
    required this.id,
    required this.name,
    required this.brand,
    required this.pciVersion,
    required this.length,
    required this.powerDraw,
    required this.price,
  });

  // Factory method to create a Gpu from JSON
  factory Gpu.fromJson(Map<String, dynamic> json) {
    return Gpu(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      pciVersion: json['pci_version'],
      length: json['length'],
      powerDraw: json['power_draw'],
      price: json['price'].toDouble(),
    );
  }

  // Method to convert a Gpu to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'pci_version': pciVersion,
      'length': length,
      'power_draw': powerDraw,
      'price': price,
    };
  }
}
