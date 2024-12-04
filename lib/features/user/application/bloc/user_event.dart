part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserEvent extends UserEvent {
  final String userId;

  const GetUserEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class UpdateUserEvent extends UserEvent {
  final String? name;
  final String? email;
  final String? phone;
  final String? password;
  final String? image;


  const UpdateUserEvent({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.image
  });

  // @override
  // List<Object> get props => [name, email, phone, password];
}
