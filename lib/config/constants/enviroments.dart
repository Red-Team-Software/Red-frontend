import 'package:GoDeli/features/common/application/bloc/select_datasource_bloc_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static late SelectDatasourceBloc datasource;

  static initEnvironment(SelectDatasourceBloc bloc) async {
    await dotenv.load(fileName: '.env');
    datasource = bloc;
  }

  static String getApiUrl() {
    switch (datasource.state.isRed) {
      case true:
        print('Entre a rojo');
        return dotenv.env['API_URL'] ?? 'no hay api key';
      case false:
        print('Entre a blue');
        return dotenv.env['API_URL_BLUE'] ?? 'no hay api blue key';
    }
  }

  static String getStripePublishableKey() {
    switch (datasource.state.isRed) {
      case true:
        return dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? 'no hay stripe key';
      case false:
        return dotenv.env['STRIPE_PUBLISHABLE_KEY_BLUE'] ?? 'no hay stripe blue key';
    }
  }

  // static String backendApi = dotenv.env['API_URL'] ?? 'no hay api key';
  // static String stripePublishableKey =
  //     dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? 'no hay stripe key';

  // static String backendApiBlue =
  //     dotenv.env['API_URL_BLUE'] ?? 'no hay api blue key';
  // static String stripePublishableKeyBlue =
  //     dotenv.env['STRIPE_PUBLISHABLE_KEY_BLUE'] ?? 'no hay stripe blue key';
}
