import 'package:GoDeli/features/user/domain/user.dart';

class LoginResponse {
  final User user;
  final String token;

  LoginResponse(this.user, this.token);

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> newjson = {
      'id': json['id'],
      'name': json['name'],
      'email': json['token'],
      'phone': json['phone'],
    };
    return LoginResponse(
      User.fromJson(newjson), 
      json['token']
    );
  }
}
