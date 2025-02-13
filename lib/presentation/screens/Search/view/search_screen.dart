import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/search/application/bloc/bloc.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
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
  final language =  context.watch<LanguagesCubit>().state.selected.language;

    return Scaffold(
        appBar: AppBar(
          title: 
          TranslationWidget(
            message:'Search',
            toLanguage: language,
            builder: (translated) => Text(
                translated
            ), 
          ),
        ),
        body: const SearchBody(),
        );
  }
}
