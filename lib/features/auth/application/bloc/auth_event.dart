part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class LogoutEvent extends AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;
  final String addressName;
  final num latitude;
  final num longitude;


  const RegisterEvent({
    required this.email, 
    required this.password, 
    required this.fullName, 
    required this.phoneNumber, 
    required this.addressName, 
    required this.latitude, 
    required this.longitude
  });

  @override
  List<Object> get props => [email, password];
}

class CheckAuthEvent extends AuthEvent {}
