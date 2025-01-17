import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static String backendApi = dotenv.env['API_URL'] ?? 'no hay api key';
  static String stripePublishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? 'no hay stripe key';
}
