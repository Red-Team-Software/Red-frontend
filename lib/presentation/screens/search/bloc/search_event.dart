part of 'search_bloc.dart';

abstract class SearchEvent  extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];

}

/// {@template custom_search_event}
/// Event added when some custom logic happens
/// {@endtemplate}
class CustomSearchEvent extends SearchEvent {
  /// {@macro custom_search_event}
  const CustomSearchEvent();
}
