import 'package:GoDeli/presentation/core/translation/translation_util.dart';
import 'package:GoDeli/presentation/core/translation/translator_api.dart';
import 'package:flutter/material.dart';


class TranslationWidget extends StatefulWidget {
  final String message;
  final String toLanguage;
  final Widget Function(String translation) builder;

  const TranslationWidget({
    super.key,
    required this.message,
    required this.toLanguage,
    required this.builder,
  });

  @override
  _TranslationWidgetState createState() => _TranslationWidgetState();
}

class _TranslationWidgetState extends State<TranslationWidget> {
  late String translation = '';

  @override
  Widget build(BuildContext context) {
    const fromLanguageCode = 'es';
    final toLanguageCode = Translations.getLanguageCode(widget.toLanguage);

    return FutureBuilder(
      future: TranslationApi.translate(widget.message, fromLanguageCode ,toLanguageCode),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return buildWaiting();
          default:
            if (snapshot.hasError) {
              translation = 'Could not translate due to Network problems';
            } else {
              translation = snapshot.data;
            }
            return widget.builder(translation);
        }
      },
    );
  }

  Widget buildWaiting() =>
      translation == '' ? Container() : widget.builder(translation);
}