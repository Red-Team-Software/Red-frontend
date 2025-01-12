
class AddFundsZelleDto {
  final String email;
  final double amount;
  final String reference;
  final String paymentId;

  AddFundsZelleDto({
    required this.email,
    required this.amount,
    required this.reference,
    required this.paymentId
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'amount': amount,
      'reference': reference,
      'paymentId': paymentId
    };
  }
}