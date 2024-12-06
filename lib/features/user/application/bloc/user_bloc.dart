import 'package:GoDeli/features/user/application/use_cases/get_user_use_case.dart';
import 'package:GoDeli/features/user/domain/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  
  final GetUserUseCase getUserUseCase;
  
  UserBloc({
    required this.getUserUseCase
  }) : super(UserLoading()) {
    on<GetUserEvent>(_onGetUserEvent);

    add(GetUserEvent());
  }

  void _onGetUserEvent(GetUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    final res = await getUserUseCase.execute(null);
    if (res.isSuccessful()) {
      emit(UserSuccess(res.getValue()));
    } else {
      emit(UserError('Failed to get user'));
    }
  }
}
