import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/order_model.dart';

class OrderStorageService {
  static const String KEY_ORDERS = 'orders';

  final SharedPreferences _prefs;

  OrderStorageService(this._prefs);

  Future<void> saveOrders(List<Order> orders) async {
    final String ordersJson = json.encode(
      orders.map((order) => order.toJson()).toList(),
    );
    await _prefs.setString(KEY_ORDERS, ordersJson);
  }

  Future<List<Order>> getOrders() async {
    final String? ordersJson = _prefs.getString(KEY_ORDERS);
    if (ordersJson == null) return [];

    final List<dynamic> ordersList = json.decode(ordersJson);
    return ordersList.map((json) => Order.fromJson(json)).toList();
  }
}
