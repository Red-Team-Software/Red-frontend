import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bundle_details_event.dart';
part 'bundle_details_state.dart';

class BundleDetailsBloc extends Bloc<BundleDetailsEvent, BundleDetailsState> {
  BundleDetailsBloc() : super(BundleDetailsInitial()) {
    on<BundleDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
