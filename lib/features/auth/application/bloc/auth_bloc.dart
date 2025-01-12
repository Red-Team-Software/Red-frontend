import 'package:GoDeli/features/auth/application/dto/login_dto.dart';
import 'package:GoDeli/features/auth/application/dto/register_dto.dart';
import 'package:GoDeli/features/auth/application/use_cases/check_auth_use_case.dart';
import 'package:GoDeli/features/auth/application/use_cases/log_out_use_case.dart';
import 'package:GoDeli/features/auth/application/use_cases/login_use_case.dart';
import 'package:GoDeli/features/auth/application/use_cases/register_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/add_user_direction_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/update_user_use_case.dart';
import 'package:GoDeli/features/user/domain/dto/add_direction_dto.dart';
import 'package:GoDeli/features/user/domain/dto/update_user_dto.dart';
import 'package:GoDeli/features/user/domain/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final CheckAuthUseCase checkAuthUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final AddUserDirectionUseCase addUserDirectionUseCase;
  AuthBloc(
      {required this.loginUseCase,
      required this.registerUseCase,
      required this.logoutUseCase,
      required this.checkAuthUseCase,
      required this.updateUserUseCase,
      required this.addUserDirectionUseCase})
      : super(AuthState()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<CheckAuthEvent>(_onCheckAuthEvent);

    add(CheckAuthEvent());
  }

  void _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res =
        await loginUseCase.execute(LoginDto(event.email, event.password));
    if (!res.isSuccessful()) {
      emit(AuthError('Invalid credentials'));
    }
    emit(Authenticated(res.getValue()));
  }

  void _onRegisterEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final resRegister = await registerUseCase.execute(RegisterDto(
        email: event.email,
        password: event.password,
        name: event.fullName,
        phone: event.phoneNumber));
    if (!resRegister.isSuccessful()) {
      emit(AuthError('Registering failed'));
      return;
    }

    if (event.image != null) {
      final resUpdate = await updateUserUseCase.execute(UpdateUserDto(
        image: event.image,
      ));
      if (!resUpdate.isSuccessful()) {
        emit(AuthError('Updating user failed'));
      }
    }

    final resDirections = await addUserDirectionUseCase.execute(event.address);
    if (!resDirections.isSuccessful()) {
      print('El error es: ${resDirections.getError()}');
      emit(AuthError('Failed to add user direction'));
    }
    emit(Authenticated(resRegister.getValue()));
  }

  void _onLogoutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await logoutUseCase.execute(null);
    if (res.isSuccessful()) {
      emit(UnAuthenticated());
      print('Deslogueado');
    } else {
      emit(AuthError('Logout failed'));
    }
  }

  _onCheckAuthEvent(CheckAuthEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await checkAuthUseCase.execute(null);

    if (res.isSuccessful()) {
      emit(Authenticated(res.getValue()));
    } else {
      emit(UnAuthenticated());
    }
  }
}
