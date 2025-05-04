class CheckoutException implements Exception {
  final String message;
  
  CheckoutException(this.message);
  
  @override
  String toString() => message;
}
