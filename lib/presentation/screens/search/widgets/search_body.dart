import 'package:flutter/material.dart';
import 'package:GoDeli/presentation/screens/search/bloc/bloc.dart';

/// {@template search_body}
/// Body of the SearchPage.
///
/// Add what it does
/// {@endtemplate}
class SearchBody extends StatelessWidget {
  /// {@macro search_body}
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Center(child: Text(state.customProperty));
      },
    );
  }
}
