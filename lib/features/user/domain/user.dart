import 'package:GoDeli/features/user/domain/user_direction.dart';

class User {
  String id;
  String fullName;
  String email;
  String phone;
  List<UserDirection> directions;
  // File? image;
  String? image;
  Wallet wallet;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.directions,
    this.image,
    required this.wallet,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['name'],
      email: json['email'],
      phone: json['phone'],
      directions: json['directions'] == null
          ? []
          : (json['directions'] as List)
              .map((e) => UserDirection.fromJson(e))
              .toList(),
      image: json['image'],
      wallet: Wallet.fromJson(json['wallet']),
    );
  }
}

class Wallet {
  String id;
  String currency;
  double amount;

  Wallet({
    required this.id,
    required this.currency,
    required this.amount,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['walletId'],
      currency: json['Ballance']['currency'],
      amount: json['Ballance']['amount'] is double ?
        json['Ballance']['amount'] :
        double.tryParse(json['Ballance']['amount'].toString()),
    );
  }
}