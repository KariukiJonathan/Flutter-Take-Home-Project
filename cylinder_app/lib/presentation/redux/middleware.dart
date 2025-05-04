import 'package:cylinder_app/data/models/order_model.dart';
import 'package:cylinder_app/presentation/screens/checkout_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:dio/dio.dart';
import 'app_state.dart';
import 'actions.dart';
import '../../data/datasources/cylinder_api.dart';
import '../../data/models/cylinder_model.dart';
// import '../../core/errors/exceptions.dart';

List<Middleware<AppState>> createMiddleware() {
  return [
    TypedMiddleware<AppState, FetchCylindersAction>(_fetchCylinders),
    TypedMiddleware<AppState, CheckoutInitiateAction>(_handleCheckout),
    // Add more middlewares as needed
  ];
}

void _fetchCylinders(
  Store<AppState> store,
  FetchCylindersAction action,
  NextDispatcher next,
) async {
  next(action);

  try {
    final cylinderApi = CylinderApi();
    final cylindersData = await cylinderApi.getCylinders();
    final cylinders = cylindersData
        .map((json) => Cylinder.fromJson(json))
        .toList();
    
    store.dispatch(FetchCylindersSuccessAction(cylinders));
  } on DioError catch (e) {
    store.dispatch(FetchCylindersErrorAction(
      'Network error: ${e.message}',
    ));
  } catch (e) {
    store.dispatch(FetchCylindersErrorAction(
      'Error fetching cylinders: ${e.toString()}',
    ));
  }
}

void _handleCheckout(
  Store<AppState> store,
  CheckoutInitiateAction action,
  NextDispatcher next,
) async {
  next(action);

  if (store.state.cart.isEmpty) {
    store.dispatch(CheckoutFailureAction('Cart is empty'));
    return;
  }

  store.dispatch(UpdateCheckoutStateAction(isProcessingCheckout: true));

  try {
    // Simulate payment processing
    await Future.delayed(Duration(seconds: 2));

    // Create new order
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: List.from(store.state.cart),
      totalAmount: store.state.cart.fold(
        0,
        (sum, item) => sum + item.cylinder.price,
      ),
      currency: store.state.cart.first.cylinder.currency,
      orderDate: DateTime.now(),
      status: 'completed',
    );


    // Dispatch success action
    store.dispatch(CheckoutSuccessAction(order));

    // Navigate to success screen
    Navigator.pushReplacement(
      action.context,
      MaterialPageRoute(
        builder: (context) => CheckoutResultScreen(success: true, order: order),
      ),
    );
  } catch (e) {
    store.dispatch(CheckoutFailureAction(e.toString()));
    
    // Navigate to failure screen
    Navigator.pushReplacement(
      action.context,
      MaterialPageRoute(
        builder: (context) => CheckoutResultScreen(
          success: false,
          error: e.toString(),
        ),
      ),
    );
  } finally {
    store.dispatch(UpdateCheckoutStateAction(isProcessingCheckout: false));
  }
}


// Optional: Add more middleware functions for other async operations

// void _saveToLocalStorage(
//   Store<AppState> store,
//   dynamic action,
//   NextDispatcher next,
// ) async {
//   next(action);

//   // Save state to local storage after certain actions
//   if (action is AddToCartAction ||
//       action is RemoveFromCartAction ||
//       action is ClearCartAction) {
//     try {
//       // Implement local storage logic here
//       // await LocalStorage.saveCart(store.state.cart);
//     } catch (e) {
//       print('Error saving to local storage: $e');
//     }
//   }
// }
