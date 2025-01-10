class AddFundsPagoMovilDto {
  final double amount;
  final String phone;
  final String reference;
  final String bank;
  final String identification;
  final String paymentId;

  AddFundsPagoMovilDto(
      {required this.amount,
      required this.phone,
      required this.reference,
      required this.bank,
      required this.identification,
      required this.paymentId});

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'phone': phone,
      'reference': reference,
      'bank': bank,
      'cedula': identification,
      'paymentId': paymentId
    };
  }
}
