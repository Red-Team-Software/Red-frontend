abstract class IOrderDatasource {
  Future<void> processPayment({
    required double amount,
    required String currency,
    required String paymentMethod,
    required String stripePaymentMethod,
    required String address,
    required List<Map<String, dynamic>> bundles,
    required List<Map<String, dynamic>> products,
  });
}
