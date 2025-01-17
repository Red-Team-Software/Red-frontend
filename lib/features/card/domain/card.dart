class Card {
  final String id;
  final String brand;
  final String last4;
  final int expMonth;
  final int expYear;

  Card({
    required this.id,
    required this.brand,
    required this.last4,
    required this.expMonth,
    required this.expYear,
  });

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json['id'] as String,
      brand: json['brand'] as String,
      last4: json['last4'] as String,
      expMonth: json['exp_month'] as int,
      expYear: json['exp_year'] as int,
    );
  }

  static List<Card> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => Card.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
