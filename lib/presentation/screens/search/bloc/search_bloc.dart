import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(const SearchInitial()) {
    on<CustomSearchEvent>(_onCustomSearchEvent);
  }

  FutureOr<void> _onCustomSearchEvent(
    CustomSearchEvent event,
    Emitter<SearchState> emit,
  ) {
    // TODO: Add Logic
  }
}
