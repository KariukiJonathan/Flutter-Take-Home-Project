// lib/presentation/redux/actions.dart

import 'package:flutter/material.dart';
import '../../data/models/cylinder_model.dart';
import '../../data/models/order_model.dart';

// Fetch Cylinders Actions
class FetchCylindersAction {}

class FetchCylindersSuccessAction {
  final List<Cylinder> cylinders;
  FetchCylindersSuccessAction(this.cylinders);
}

class FetchCylindersErrorAction {
  final String error;
  FetchCylindersErrorAction(this.error);
}

// Cart Actions
class AddToCartAction {
  final Cylinder cylinder;
  AddToCartAction(this.cylinder);
}

class RemoveFromCartAction {
  final String cartItemId;
  RemoveFromCartAction(this.cartItemId);
}

// Checkout Actions
class CheckoutInitiateAction {
  final BuildContext context;
  CheckoutInitiateAction(this.context);
}

class UpdateCheckoutStateAction {
  final bool isProcessingCheckout;
  UpdateCheckoutStateAction({required this.isProcessingCheckout});
}

class CheckoutSuccessAction {
  final Order order;
  CheckoutSuccessAction(this.order);
}

class CheckoutFailureAction {
  final String error;
  CheckoutFailureAction(this.error);
}

// Order History Actions
class FetchOrdersAction {}

class FetchOrdersSuccessAction {
  final List<Order> orders;
  FetchOrdersSuccessAction(this.orders);
}

class FetchOrdersFailureAction {
  final String error;
  FetchOrdersFailureAction(this.error);
}

class ClearCartAction {}