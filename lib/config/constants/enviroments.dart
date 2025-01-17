import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static String backendApi = dotenv.env['API_URL'] ?? 'no hay api key';
  static String stripePublishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? 'no hay stripe key';

  static String backendApiBlue = dotenv.env['API_URL_BLUE'] ?? 'no hay api blue key';
  static String stripePublishableKeyBlue = dotenv.env['STRIPE_PUBLISHABLE_KEY_BLUE'] ?? 'no hay stripe blue key';

  // static String getApiUrl() {
  //   switch (dataSourceBloc.state.dataSourceIndex) {
  //     case 0:
  //       return dotenv.env['API_URL'] ?? 'API_URL is not configured';
  //     case 1:
  //       return dotenv.env['API_URL_BLUE'] ??
  //           'API_URL_BLUE is not configured';
  //     default:
  //       return 'API_URL is not configured';
  //   }
  // }

  // static String getStripeUrl() {
  //   switch (dataSourceBloc.state.dataSourceIndex) {
  //     case 0:
  //       return dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? 'STRIPE_PUBLISHABLE_KEY is not configured';
  //     case 1:
  //       return dotenv.env['STRIPE_PUBLISHABLE_KEY_BLUE'] ??
  //           'STRIPE_PUBLISHABLE_KEY_BLUE is not configured';
  //     default:
  //       return 'STRIPE_PUBLISHABLE_KEY is not configured';
  //   }
  // }

}
