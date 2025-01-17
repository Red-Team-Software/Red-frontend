import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:GoDeli/presentation/screens/languages/widgets/language_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguagesBody extends StatelessWidget {
  const LanguagesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguagesCubit, LanguagesState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.00, left: 16.00, right: 16.00),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 24.0,
                childAspectRatio: 0.8),
            itemCount: state.languagesList.length,
            itemBuilder: (context, index) {
              final lan = state.languagesList[index];
              return LanguageItem(lan: lan);
            },
          ),
        );
      },
    );
  }
}
