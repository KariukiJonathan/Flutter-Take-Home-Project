// lib/data/models/cylinder_model.dart

class Cylinder {
  final String id;
  final String name;
  final double price;
  final String currency;
  final String imageUrl;

  Cylinder({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.imageUrl,
  });

  // Create a copy with some fields changed
  Cylinder copyWith({
    String? id,
    String? name,
    double? price,
    String? currency,
    String? imageUrl,
  }) {
    return Cylinder(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  // Convert Cylinder to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'currency': currency,
      'image_url': imageUrl,
    };
  }

  // Create Cylinder from JSON
  factory Cylinder.fromJson(Map<String, dynamic> json) {
    return Cylinder(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      imageUrl: json['image_url'] as String,
    );
  }

  // Override toString for debugging
  @override
  String toString() {
    return 'Cylinder{id: $id, name: $name, price: $price, currency: $currency}';
  }

  // Override equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is Cylinder &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.currency == currency &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        currency.hashCode ^
        imageUrl.hashCode;
  }
}
