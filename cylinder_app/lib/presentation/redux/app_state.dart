import '../../data/models/cylinder_model.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/models/order_model.dart';

class AppState {
  final List<Cylinder> cylinders;
  final List<CartItem> cart;
  final List<Order> orders;
  final bool isLoading;
  final String? error;
  final bool isProcessingCheckout;

  AppState({
    required this.cylinders,
    required this.cart,
    required this.orders,
    required this.isLoading,
    this.error,
    this.isProcessingCheckout = false,
  });

  // Initial state factory constructor
  factory AppState.initial() {
    return AppState(
      cylinders: [],
      cart: [],
      orders: [],
      isLoading: false,
      error: null,
      isProcessingCheckout: false,
    );
  }

  // CopyWith method for immutable state updates
  AppState copyWith({
    List<Cylinder>? cylinders,
    List<CartItem>? cart,
    List<Order>? orders,
    bool? isLoading,
    String? error,
    bool? isProcessingCheckout,
  }) {
    return AppState(
      cylinders: cylinders ?? this.cylinders,
      cart: cart ?? this.cart,
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isProcessingCheckout: isProcessingCheckout ?? this.isProcessingCheckout,
    );
  }

  // Helper methods for state calculations
  double get cartTotal {
    return cart.fold(0, (sum, item) => sum + (item.cylinder.price * item.quantity));
  }

  bool get hasItemsInCart => cart.isNotEmpty;

  int get cartItemCount => cart.length;

  bool get hasError => error != null;

  String? getCylinderCurrency() {
    return cart.isNotEmpty ? cart.first.cylinder.currency : null;
  }

  //toString method for debugging
  @override
  String toString() {
    return '''AppState{
      cylinders: ${cylinders.length} items,
      cart: ${cart.length} items,
      orders: ${orders.length} items,
      isLoading: $isLoading,
      error: $error,
      isProcessingCheckout: $isProcessingCheckout
    }''';
  }

  // Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppState &&
        other.cylinders == cylinders &&
        other.cart == cart &&
        other.orders == orders &&
        other.isLoading == isLoading &&
        other.error == error &&
        other.isProcessingCheckout == isProcessingCheckout;
  }

  @override
  int get hashCode {
    return cylinders.hashCode ^
        cart.hashCode ^
        orders.hashCode ^
        isLoading.hashCode ^
        error.hashCode ^
        isProcessingCheckout.hashCode;
  }
}
