import 'package:GoDeli/presentation/core/translation/translation_util.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageItem extends StatelessWidget {
  final Translations lan;

  const LanguageItem({
    super.key,
    required this.lan,
  });

  @override
  Widget build(BuildContext context) {
    final lanCubbit = context.watch<LanguagesCubit>();

    return InkWell(
      onTap: () => lanCubbit.selectLanguage(lan),
      child: Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color:
            lanCubbit.state.selected == lan ? Colors.blue[100] : Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Image.network(
                  lan.flag,
                  fit: BoxFit.contain,
                  width: 70.00,
                ),
              ),
              Text(
                lan.language,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 8.00,
              )
            ],
          ),
        ),
      ),
    );
  }
}
