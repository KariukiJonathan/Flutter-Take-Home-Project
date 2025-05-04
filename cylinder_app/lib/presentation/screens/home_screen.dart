import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../redux/app_state.dart';
import '../redux/actions.dart';
import '../../data/models/cylinder_model.dart';
import '../widgets/cylinder_card.dart';
import 'cart_screen.dart';

class _ViewModel {
  final List<Cylinder> cylinders;
  final bool isLoading;
  final Function(Cylinder) addToCart;

  _ViewModel({
    required this.cylinders,
    required this.isLoading,
    required this.addToCart,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      cylinders: store.state.cylinders,
      isLoading: store.state.isLoading,
      // Correctly define the addToCart function
      addToCart: (cylinder) {
        store.dispatch(AddToCartAction(cylinder));
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LPG Cylinders'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.pushNamed(context, '/order-history');
            },
          ),
          StoreConnector<AppState, int>(
            converter: (store) => store.state.cart.length,
            builder: (context, cartItemCount) {
              return Badge(
                label: Text('$cartItemCount'),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: StoreConnector<AppState, _ViewModel>(
        onInit: (store) {
          store.dispatch(FetchCylindersAction());
        },
        converter: (store) => _ViewModel.fromStore(store),
        builder: (context, vm) {
          if (vm.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          
          return GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: vm.cylinders.length,
            itemBuilder: (context, index) {
              final cylinder = vm.cylinders[index];
              return CylinderCard(
                cylinder: cylinder,
                onAddToCart: () => vm.addToCart(cylinder),
              );
            },
          );
        },
      ),
    );
  }
}
