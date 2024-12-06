import 'package:GoDeli/features/user/domain/user_direction.dart';

class User {
  String id;
  String fullName;
  String email;
  String phone;
  // List<UserDirection> directions;
  // File? image;
  String? image;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    // required this.directions,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['name'],
      email: json['email'],
      phone: json['phone'],
      // directions: json['directions'] == null
      //     ? []
      //     : (json['directions'] as List)
      //         .map((e) => UserDirection.fromJson(e))
      //         .toList(),
      image: json['image'],
    );
  }
}
