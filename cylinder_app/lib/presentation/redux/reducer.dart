import 'app_state.dart';import 'actions.dart';
import '../../data/models/cart_item_model.dart';
// import '../../data/models/cylinder_model.dart';
// import '../../data/models/order_model.dart';

AppState reducer(AppState state, dynamic action) {
  // Fetch Cylinders
  if (action is FetchCylindersAction) {
    return state.copyWith(
      isLoading: true,
      error: null,
    );
  }

  if (action is FetchCylindersSuccessAction) {
    return state.copyWith(
      cylinders: action.cylinders,
      isLoading: false,
      error: null,
    );
  }

  if (action is FetchCylindersErrorAction) {
    return state.copyWith(
      isLoading: false,
      error: action.error,
    );
  }

  // Cart Actions
  if (action is AddToCartAction) {
    final newCartItem = CartItem(
      cartItemId: DateTime.now().millisecondsSinceEpoch.toString(),
      cylinder: action.cylinder,
      quantity: 1,
    );
    return state.copyWith(
      cart: [...state.cart, newCartItem],
      error: null,
    );
  }

  if (action is RemoveFromCartAction) {
    return state.copyWith(
      cart: state.cart.where((item) => item.cartItemId != action.cartItemId).toList(),
      error: null,
    );
  }

  // Checkout Actions
  if (action is CheckoutInitiateAction) {
    return state.copyWith(
      isProcessingCheckout: true,
      error: null,
    );
  }

  if (action is UpdateCheckoutStateAction) {
    return state.copyWith(
      isProcessingCheckout: action.isProcessingCheckout,
    );
  }

  if (action is CheckoutSuccessAction) {
    return state.copyWith(
      cart: [], // Clear the cart
      orders: [...state.orders, action.order],
      isProcessingCheckout: false,
      error: null,
    );
  }

  if (action is CheckoutFailureAction) {
    return state.copyWith(
      isProcessingCheckout: false,
      error: action.error,
    );
  }

  // Order History Actions
  if (action is FetchOrdersSuccessAction) {
    return state.copyWith(
      orders: action.orders,
      isLoading: false,
      error: null,
    );
  }

  if (action is FetchOrdersFailureAction) {
    return state.copyWith(
      isLoading: false,
      error: action.error,
    );
  }

  if (action is ClearCartAction) {
    return state.copyWith(
      cart: [],
      error: null,
    );
  }
  
  return state;
}
