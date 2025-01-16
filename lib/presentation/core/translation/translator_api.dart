// import 'dart:convert';

// import 'package:html_unescape/html_unescape.dart';
// import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';

class TranslationApi {

  static Future<String> translate(
      String message, String fromLanguageCode, String toLanguageCode) async {
    
    if (fromLanguageCode == toLanguageCode) {
      return message;
    }
    final translation = await GoogleTranslator().translate(
      message,
      from: fromLanguageCode,
      to: toLanguageCode,
    );

    return translation.text;
  }
}