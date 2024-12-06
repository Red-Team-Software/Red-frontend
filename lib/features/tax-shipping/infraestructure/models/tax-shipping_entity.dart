class TaxShippingEntity {
  final double taxes;
  final double shipping;

  TaxShippingEntity({
    required this.taxes,
    required this.shipping,
  });

  factory TaxShippingEntity.fromJson(Map<String, dynamic> json) {
    return TaxShippingEntity(
      taxes: json['taxes'],
      shipping: json['shipping'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taxes': taxes,
      'shipping': shipping,
    };
  }
}
