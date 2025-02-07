class Ram {
  final String name;
  final String brand;
  final int capacity; // Capacità in GB
  final double price;

  Ram({
    required this.name,
    required this.brand,
    required this.capacity,
    required this.price,
  });

  factory Ram.fromJson(Map<String, dynamic> json) {
    return Ram(
      name: json['name'],
      brand: json['brand'],
      capacity: json['capacity'],
      price: json['price'].toDouble(),
    );
  }
}
