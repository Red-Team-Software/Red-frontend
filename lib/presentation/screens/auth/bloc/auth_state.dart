part of 'auth_bloc.dart';

/// {@template auth_state}
/// AuthState description
/// {@endtemplate}
class AuthState extends Equatable {
  /// {@macro auth_state}
  const AuthState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current AuthState with property changes
  AuthState copyWith({
    String? customProperty,
  }) {
    return AuthState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template auth_initial}
/// The initial state of AuthState
/// {@endtemplate}
class AuthInitial extends AuthState {
  /// {@macro auth_initial}
  const AuthInitial() : super();
}
