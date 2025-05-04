import 'package:flutter/foundation.dart';
import 'cart_item_model.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final String currency;
  final DateTime orderDate;
  final String status; // 'completed', 'failed', 'pending'

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.currency,
    required this.orderDate,
    required this.status,
  });

  // Create a copy of Order with some fields changed
  Order copyWith({
    String? id,
    List<CartItem>? items,
    double? totalAmount,
    String? currency,
    DateTime? orderDate,
    String? status,
  }) {
    return Order(
      id: id ?? this.id,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      currency: currency ?? this.currency,
      orderDate: orderDate ?? this.orderDate,
      status: status ?? this.status,
    );
  }

  // Convert Order object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'currency': currency,
      'orderDate': orderDate.toIso8601String(),
      'status': status,
    };
  }

  // Create Order object from JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalAmount: json['totalAmount'] as double,
      currency: json['currency'] as String,
      orderDate: DateTime.parse(json['orderDate'] as String),
      status: json['status'] as String,
    );
  }

  // Helper methods
  bool get isCompleted => status == 'completed';
  bool get isFailed => status == 'failed';
  bool get isPending => status == 'pending';

  // Get total number of items
  int get itemCount {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  // Get formatted date string
  String get formattedDate {
    return '${orderDate.day}/${orderDate.month}/${orderDate.year} '
        '${orderDate.hour}:${orderDate.minute.toString().padLeft(2, '0')}';
  }

  // Get formatted total amount
  String get formattedTotal {
    return '$currency ${totalAmount.toStringAsFixed(2)}';
  }

  // Override toString for debugging
  @override
  String toString() {
    return 'Order{id: $id, items: ${items.length}, totalAmount: $totalAmount, '
        'currency: $currency, orderDate: $orderDate, status: $status}';
  }

  // Override equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is Order &&
        other.id == id &&
        listEquals(other.items, items) &&
        other.totalAmount == totalAmount &&
        other.currency == currency &&
        other.orderDate == orderDate &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        items.hashCode ^
        totalAmount.hashCode ^
        currency.hashCode ^
        orderDate.hashCode ^
        status.hashCode;
  }

  // Optional: Add status update methods
  Order markAsCompleted() {
    return copyWith(status: 'completed');
  }

  Order markAsFailed() {
    return copyWith(status: 'failed');
  }

  Order markAsPending() {
    return copyWith(status: 'pending');
  }

  // Optional: Add validation method
  static bool isValidStatus(String status) {
    return ['completed', 'failed', 'pending'].contains(status);
  }

  // Optional: Factory constructor for pending orders
  factory Order.pending({
    required String id,
    required List<CartItem> items,
    required double totalAmount,
    required String currency,
  }) {
    return Order(
      id: id,
      items: items,
      totalAmount: totalAmount,
      currency: currency,
      orderDate: DateTime.now(),
      status: 'pending',
    );
  }

  // Optional: Factory constructor for completed orders
  factory Order.completed({
    required String id,
    required List<CartItem> items,
    required double totalAmount,
    required String currency,
    required DateTime orderDate,
  }) {
    return Order(
      id: id,
      items: items,
      totalAmount: totalAmount,
      currency: currency,
      orderDate: orderDate,
      status: 'completed',
    );
  }

  // Optional: Calculate total amount from items
  static double calculateTotalAmount(List<CartItem> items) {
    return items.fold(
      0,
      (sum, item) => sum + (item.cylinder.price * item.quantity),
    );
  }
}
