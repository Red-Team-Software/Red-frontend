part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

final class UserSuccess extends UserState {
  final User user;

  UserSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class UserLoading extends UserState {}

final class UserError extends UserState {
  final String message;

  UserError(this.message);
}

