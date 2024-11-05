import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial()) {
    on<CustomAuthEvent>(_onCustomAuthEvent);
  }

  FutureOr<void> _onCustomAuthEvent(
    CustomAuthEvent event,
    Emitter<AuthState> emit,
  ) {
    // TODO: Add Logic
  }
}
