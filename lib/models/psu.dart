class Psu {
  final int id;
  final String name;
  final String brand;
  final int wattage;
  final String efficiencyRating;
  final double price;

  Psu({
    required this.id,
    required this.name,
    required this.brand,
    required this.wattage,
    required this.efficiencyRating,
    required this.price,
  });

  factory Psu.fromJson(Map<String, dynamic> json) {
    return Psu(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      wattage: json['wattage'],
      efficiencyRating: json['efficiency_rating'],
      price: json['price'].toDouble(),
    );
  }
}
