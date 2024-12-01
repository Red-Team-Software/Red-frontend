import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/presentation/screens/Search/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:GoDeli/presentation/screens/search/widgets/search_body.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  static const String name = "search_page";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SearchBloc>(),
      child: const SearchView(),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: const SearchBody(),
        );
  }
}
