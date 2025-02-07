class CpuCooler {
  final int id;
  final String name;
  final String brand;
  final List<String> socketSupport; // Array di socket supportati
  final int tdpSupport; // Watt supportati dal dissipatore
  final double price;

  CpuCooler({
    required this.id,
    required this.name,
    required this.brand,
    required this.socketSupport,
    required this.tdpSupport,
    required this.price,
  });

  factory CpuCooler.fromJson(Map<String, dynamic> json) {
    return CpuCooler(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      socketSupport: List<String>.from(json['socket_support']),
      tdpSupport: json['tdp_support'],
      price: json['price'].toDouble(),
    );
  }
}
