import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:GoDeli/presentation/screens/languages/widgets/languages_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LanguageScreen extends StatelessWidget {
  static const name = 'languages_screen';
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LanguageScreenView();
  }
}

class LanguageScreenView extends StatelessWidget {
  const LanguageScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: TranslationWidget(
          message: 'Idiomas',
          toLanguage: context.watch<LanguagesCubit>().state.selected.language,

          builder: (translated) =>Text(
            translated,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),

      body: const LanguagesBody(),
    );
  }
}
