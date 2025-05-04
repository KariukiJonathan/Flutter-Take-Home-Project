import 'cylinder_model.dart';

class CartItem {
  final String cartItemId;
  final Cylinder cylinder;
  final int quantity;

  CartItem({
    required this.cartItemId,
    required this.cylinder,
    this.quantity = 1,
  });

  // Create a copy with some fields changed
  CartItem copyWith({
    String? cartItemId,
    Cylinder? cylinder,
    int? quantity,
  }) {
    return CartItem(
      cartItemId: cartItemId ?? this.cartItemId,
      cylinder: cylinder ?? this.cylinder,
      quantity: quantity ?? this.quantity,
    );
  }

  // Convert CartItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'cartItemId': cartItemId,
      'cylinder': cylinder.toJson(),
      'quantity': quantity,
    };
  }

  // Create CartItem from JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      cartItemId: json['cartItemId'] as String,
      cylinder: Cylinder.fromJson(json['cylinder'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
    );
  }

  // Calculate total price for this cart item
  double get totalPrice => cylinder.price * quantity;

  // Override toString for debugging
  @override
  String toString() {
    return 'CartItem{cartItemId: $cartItemId, cylinder: ${cylinder.name}kg, quantity: $quantity}';
  }

  // Override equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is CartItem &&
        other.cartItemId == cartItemId &&
        other.cylinder == cylinder &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => cartItemId.hashCode ^ cylinder.hashCode ^ quantity.hashCode;

  // Optional: Factory constructor for single ie item
  factory CartItem.single({
    required String cartItemId,
    required Cylinder cylinder,
  }) {
    return CartItem(
      cartItemId: cartItemId,
      cylinder: cylinder,
      quantity: 1,
    );
  }

  // Optional: Method to increase quantity
  CartItem incrementQuantity() {
    return copyWith(quantity: quantity + 1);
  }

  // Optional: Method to decrease quantity
  CartItem decrementQuantity() {
    if (quantity > 1) {
      return copyWith(quantity: quantity - 1);
    }
    return this;
  }
}
