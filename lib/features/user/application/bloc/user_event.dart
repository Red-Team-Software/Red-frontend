part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final UpdateUserDto updateUserDto;


  const UpdateUserEvent({
    required this.updateUserDto,
  });

  // @override
  // List<Object?> get props => [name, email, phone, password, image];
}

class AddUserDirectionEvent extends UserEvent {
  final AddUserDirectionListDto userDirection;

  const AddUserDirectionEvent({
    required this.userDirection,
  });
}

class DeleteUserDirectionEvent extends UserEvent {
  final DeleteUpdateUserDirectionListDto userDirection;

  const DeleteUserDirectionEvent({
    required this.userDirection,
  });
}

class UpadateUserDirectionEvent extends UserEvent {
  final DeleteUpdateUserDirectionListDto userDirection;

  const UpadateUserDirectionEvent({
    required this.userDirection,
  });
}
