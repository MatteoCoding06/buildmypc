class Storage {
  final int id;
  final String name;
  final String brand;
  final int capacity; // Capacità in GB
  final String type; // Tipo: SSD, HDD, etc.
  final double price; // Prezzo
  final String interface; // Interfaccia di connessione

  Storage({
    required this.id,
    required this.name,
    required this.brand,
    required this.capacity,
    required this.type,
    required this.price,
    required this.interface, // Aggiungi l'interfaccia
  });

  // Metodo per creare un'istanza di Storage da JSON
  factory Storage.fromJson(Map<String, dynamic> json) {
    return Storage(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      capacity: json['capacity'],
      type: json['type'],
      price: json['price'].toDouble(),
      interface: json[
          'interface'], // Assicurati che l'interfaccia venga presa dal JSON
    );
  }

  // Metodo per convertire un'istanza di Storage in un formato JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'capacity': capacity,
      'type': type,
      'price': price,
      'interface': interface, // Aggiungi l'interfaccia nei dati JSON
    };
  }
}
