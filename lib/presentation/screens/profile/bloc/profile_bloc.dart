import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileInitial()) {
    on<CustomProfileEvent>(_onCustomProfileEvent);
  }

  FutureOr<void> _onCustomProfileEvent(
    CustomProfileEvent event,
    Emitter<ProfileState> emit,
  ) {
    // TODO: Add Logic
  }
}
