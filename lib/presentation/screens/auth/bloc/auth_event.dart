part of 'auth_bloc.dart';

abstract class AuthEvent  extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];

}

/// {@template custom_auth_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomAuthEvent extends AuthEvent {
  /// {@macro custom_auth_event}
  const CustomAuthEvent();
}
