import 'package:GoDeli/features/user/application/use_cases/add_user_direction_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/delete_user_direction_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/get_user_directions_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/get_user_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/update_user_direction_use_case.dart';
import 'package:GoDeli/features/user/application/use_cases/update_user_use_case.dart';
import 'package:GoDeli/features/user/domain/dto/add_direction_dto.dart';
import 'package:GoDeli/features/user/domain/dto/delete_update_user_direction_dto.dart';
import 'package:GoDeli/features/user/domain/dto/update_user_dto.dart';
import 'package:GoDeli/features/user/domain/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUseCase getUserUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final GetUserDirectionsUseCase getUserDirectionsUseCase;
  final AddUserDirectionUseCase addUserDirectionUseCase;
  final DeleteUserDirectionUseCase deleteUserDirectionUseCase;
  final UpdateUserDirectionUseCase updateUserDirectionUseCase;

  UserBloc(
      {required this.getUserUseCase,
      required this.updateUserUseCase,
      required this.getUserDirectionsUseCase,
      required this.addUserDirectionUseCase,
      required this.deleteUserDirectionUseCase,
      required this.updateUserDirectionUseCase})
      : super(UserLoading()) {
    on<GetUserEvent>(_onGetUserEvent);
    on<UpdateUserEvent>(_onUpdateUserEvent);
    on<AddUserDirectionEvent>(_onAddUserDirectionEvent);
    on<DeleteUserDirectionEvent>(_onDeleteUserDirectionEvent);
    on<UpdateUserDirectionEvent>(_onUpdateUserDirectionEvent);
    

    add(GetUserEvent());
  }

  void _onGetUserEvent(GetUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final res = await getUserUseCase.execute(null);
    if (!res.isSuccessful()) {
      emit(UserError('Failed to get user'));
      return;
    }
    final resDirections = await getUserDirectionsUseCase.execute(null);
    if (!resDirections.isSuccessful()) {
      emit(UserError('Failed to get user directions'));
      return;
    }
    res.getValue().directions = [...resDirections.getValue()];
    emit(UserSuccess(res.getValue()));
  }

  void _onUpdateUserEvent(
      UpdateUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final res = await updateUserUseCase.execute(event.updateUserDto);
    if (!res.isSuccessful()) {
      emit(UserError('Failed to update user'));
      return;
    }
    final resDirections = await getUserDirectionsUseCase.execute(null);
    if (!resDirections.isSuccessful()) {
      emit(UserError('Failed to get user directions'));
      return;
    }
    res.getValue().directions = [...resDirections.getValue()];
    emit(UserSuccess(res.getValue()));
  }

  void _onAddUserDirectionEvent(
      AddUserDirectionEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());

    final res = await addUserDirectionUseCase.execute(event.userDirection);
    if (!res.isSuccessful()) {
      emit(UserError('Failed to add user direction'));
      return;
    }
    final resDirections = await getUserDirectionsUseCase.execute(null);
    if (!resDirections.isSuccessful()) {
      emit(UserError('Failed to get user directions'));
      return;
    }
    res.getValue().directions = [...resDirections.getValue()];
    emit(UserSuccess(res.getValue()));
  }

  void _onDeleteUserDirectionEvent(
      DeleteUserDirectionEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final res = await deleteUserDirectionUseCase.execute(event.userDirection);
    if (!res.isSuccessful()) {
      emit(UserError('Failed to delete user direction'));
      return;
    }
    final resDirections = await getUserDirectionsUseCase.execute(null);
    if (!resDirections.isSuccessful()) {
      emit(UserError('Failed to get user directions'));
      return;
    }
    res.getValue().directions = [...resDirections.getValue()];
    emit(UserSuccess(res.getValue()));
  }

  void _onUpdateUserDirectionEvent(
      UpdateUserDirectionEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final res = await updateUserDirectionUseCase.execute(event.userDirection);
    if (!res.isSuccessful()) {
      emit(UserError('Failed to update user direction'));
      return;
    }
    final resDirections = await getUserDirectionsUseCase.execute(null);
    if (!resDirections.isSuccessful()) {
      emit(UserError('Failed to get user directions'));
      return;
    }
    res.getValue().directions = [...resDirections.getValue()];
    emit(UserSuccess(res.getValue()));
  }
}
