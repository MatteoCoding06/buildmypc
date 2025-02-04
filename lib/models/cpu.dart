class Cpu {
  final int id;
  final String name;
  final String brand;
  final String socket; // Compatibilità con la scheda madre
  final int tdp; // Consumo energetico in watt
  final double price;

  Cpu({
    required this.id,
    required this.name,
    required this.brand,
    required this.socket,
    required this.tdp,
    required this.price,
  });

  factory Cpu.fromJson(Map<String, dynamic> json) {
    return Cpu(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      socket: json['socket'],
      tdp: json['tdp'],
      price: json['price'].toDouble(),
    );
  }
}
