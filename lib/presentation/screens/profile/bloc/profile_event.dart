part of 'profile_bloc.dart';

abstract class ProfileEvent  extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];

}

/// {@template custom_profile_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomProfileEvent extends ProfileEvent {
  /// {@macro custom_profile_event}
  const CustomProfileEvent();
}
