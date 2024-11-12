part of 'search_bloc.dart';

/// {@template search_state}
/// SearchState description
/// {@endtemplate}
class SearchState extends Equatable {
  /// {@macro search_state}
  const SearchState({
    this.customProperty = 'Default Value',
  });

  /// A description for customProperty
  final String customProperty;

  @override
  List<Object> get props => [customProperty];

  /// Creates a copy of the current SearchState with property changes
  SearchState copyWith({
    String? customProperty,
  }) {
    return SearchState(
      customProperty: customProperty ?? this.customProperty,
    );
  }
}

/// {@template search_initial}
/// The initial state of SearchState
/// {@endtemplate}
class SearchInitial extends SearchState {
  /// {@macro search_initial}
  const SearchInitial() : super();
}
