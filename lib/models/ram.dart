class Ram {
  final int id;
  final String name;
  final String brand;
  final int capacity; // Capacità in GB
  final double price;

  Ram({
    required this.id,
    required this.name,
    required this.brand,
    required this.capacity,
    required this.price,
  });

  factory Ram.fromJson(Map<String, dynamic> json) {
    return Ram(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      capacity: json['capacity'],
      price: json['price'].toDouble(),
    );
  }
}
