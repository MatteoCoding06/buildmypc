class Case {
  final int id;
  final String name;
  final String brand;
  final List<String> formFactorSupport;
  final int maxGpuLength;
  final int maxPsuLength;
  final double price;

  Case({
    required this.id,
    required this.name,
    required this.brand,
    required this.formFactorSupport,
    required this.maxGpuLength,
    required this.maxPsuLength,
    required this.price,
  });

  factory Case.fromJson(Map<String, dynamic> json) {
    return Case(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      formFactorSupport: List<String>.from(json['form_factor_support']),
      maxGpuLength: json['max_gpu_length'],
      maxPsuLength: json['max_psu_length'],
      price: json['price'].toDouble(),
    );
  }
}
