import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/common/infrastructure/http_service.dart';

class NotificationDatasource {
  final IHttpService _httpService;

  NotificationDatasource(this._httpService);

  Future<Result<String>> saveToken(String token) async {
    final response = await _httpService.request(
        '/notifications/savetoken', 'POST', (json) => {},
        body: {'token': token});

    if (!response.isSuccessful()) {
      print('Entra a error');
      return Result.makeError(
          Exception('Failed to save token: ${response.getError()}'));
    }
    print('Firebase Token guardado exitosamente');
    return Result.success('Token guardado exitosamente');
  }
}
