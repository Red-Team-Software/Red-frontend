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
  final AddUserDirectionDto userDirection;

  const AddUserDirectionEvent({
    required this.userDirection,
  });
}

class DeleteUserDirectionEvent extends UserEvent {
  final DeleteUserDirectionDto userDirection;

  const DeleteUserDirectionEvent({
    required this.userDirection,
  });
}

class UpdateUserDirectionEvent extends UserEvent {
  final UpdateUserDirectionDto userDirection;

  const UpdateUserDirectionEvent({
    required this.userDirection,
  });
}
