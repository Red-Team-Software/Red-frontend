
import 'package:GoDeli/features/user/domain/user.dart';

class LoginResponse{
  final User user; 
  final String token;

  LoginResponse(this.user, this.token);

  factory LoginResponse.fromJson(Map<String, dynamic> json){
    return LoginResponse(
      User.fromJson(json['user']),
      json['token']
    );
  }
}
