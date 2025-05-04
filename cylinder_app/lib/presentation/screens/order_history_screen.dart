import 'package:cylinder_app/data/models/order_model.dart';
import 'package:cylinder_app/presentation/redux/actions.dart';
import 'package:cylinder_app/presentation/redux/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:intl/intl.dart';

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: StoreConnector<AppState, _ViewModel>(
        onInit: (store) => store.dispatch(FetchOrdersAction()),
        converter: (store) => _ViewModel.fromStore(store),
        builder: (context, vm) {
          if (vm.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (vm.orders.isEmpty) {
            return Center(child: Text('No orders yet'));
          }

          return ListView.builder(
            itemCount: vm.orders.length,
            itemBuilder: (context, index) {
              final order = vm.orders[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text('Order #${order.id}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: ${DateFormat('dd/MM/yyyy HH:mm').format(order.orderDate)}',
                      ),
                      Text(
                        'Total: ${order.currency} ${order.totalAmount.toStringAsFixed(2)}',
                      ),
                      Text('Status: ${order.status}'),
                    ],
                  ),
                  onTap: () {
                    // Navigate to order details
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _ViewModel {
  final List<Order> orders;
  final bool isLoading;

  _ViewModel({
    required this.orders,
    required this.isLoading,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      orders: store.state.orders,
      isLoading: store.state.isLoading,
    );
  }
}
