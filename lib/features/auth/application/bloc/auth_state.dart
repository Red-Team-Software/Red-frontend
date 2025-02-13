part of 'auth_bloc.dart';

class AuthState { }

class Authenticated extends AuthState {
  final User user;

  Authenticated(this.user);

}

class UnAuthenticated extends AuthState { }

class AuthLoading extends AuthState { }

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}


