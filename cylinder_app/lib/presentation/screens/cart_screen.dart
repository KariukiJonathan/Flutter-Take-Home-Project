import 'package:cylinder_app/data/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
// import '../../data/models/cylinder_model.dart';
import '../redux/app_state.dart';
import '../redux/actions.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel.fromStore(store),
        builder: (context, vm) {
          if (vm.cart.isEmpty) {
            return Center(child: Text('Your cart is empty'));
          }
          return ListView.builder(
            itemCount: vm.cart.length,
            itemBuilder: (context, index) {
              final cartItem = vm.cart[index];
              final cylinder = cartItem.cylinder;
              return ListTile(
                title: Text('${cylinder.name}kg Cylinder'),
                subtitle: Text('${cylinder.currency} ${cylinder.price}'),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () => vm.removeFromCart(cartItem.cartItemId),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel.fromStore(store),
        builder: (context, vm) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: ${vm.cart.isNotEmpty ? vm.cart.first.cylinder.currency : ""} '
                  '${vm.total.toStringAsFixed(2)}',
                ),
                ElevatedButton(
                  onPressed: vm.cart.isEmpty ? null : () => vm.initiateCheckout(context),
                  child: Text('Checkout'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ViewModel {
  final List<CartItem> cart;
  final Function(String) removeFromCart;
  final Function(BuildContext) initiateCheckout;
  final double total;

  _ViewModel({
    required this.cart,
    required this.removeFromCart,
    required this.initiateCheckout,
    required this.total,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      cart: store.state.cart,
      removeFromCart: (cartItemId) => 
          store.dispatch(RemoveFromCartAction(cartItemId)),
      initiateCheckout: (context) => 
          store.dispatch(CheckoutInitiateAction(context)),
      total: store.state.cart.fold(
        0,
        (sum, item) => sum + item.cylinder.price,
      ),
    );
  }
}
