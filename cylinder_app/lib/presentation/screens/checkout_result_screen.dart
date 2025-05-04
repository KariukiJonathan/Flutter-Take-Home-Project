import 'package:cylinder_app/data/models/order_model.dart';
import 'package:flutter/material.dart';

class CheckoutResultScreen extends StatelessWidget {
  final bool success;
  final Order? order;
  final String? error;

  const CheckoutResultScreen({
    Key? key,
    required this.success,
    this.order,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(success ? 'Order Successful' : 'Order Failed'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              success ? Icons.check_circle : Icons.error,
              size: 64,
              color: success ? Colors.green : Colors.red,
            ),
            SizedBox(height: 16),
            Text(
              success
                  ? 'Order Completed Successfully!'
                  : 'Order Failed: ${error ?? "Unknown error"}',
              textAlign: TextAlign.center,
            ),
            if (success && order != null) ...[
              SizedBox(height: 16),
              Text('Order ID: ${order!.id}'),
              Text(
                'Total: ${order!.currency} ${order!.totalAmount.toStringAsFixed(2)}',
              ),
            ],
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home',
                  (route) => false,
                );
              },
              child: Text('Return to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
