class PaymentMethod {
  String id;
  String name;
  String state;
  String imageUrl;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.state,
    required this.imageUrl,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['id']??json['idPayment'],
      name: json['name'],
      state: json['state'],
      imageUrl: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'state': state,
      'image': imageUrl,
    };
  }
}
