import 'package:GoDeli/features/common/infrastructure/http_service.dart';
import 'package:GoDeli/features/card/domain/card.dart';
import 'package:GoDeli/features/card/domain/datasource/card_datasource.dart';

class CardDatasourceImpl implements ICardDatasource {
  final IHttpService httpService;

  CardDatasourceImpl({required this.httpService});

  @override
  Future<void> addCard({required String idCard}) async {
    final res = await httpService.request(
      '/payment/method/user/add/card',
      'POST',
      (json) => null,
      body: {
        "idCard": idCard,
      },
    );

    if (!res.isSuccessful()) throw Exception(res.getError());
  }

  @override
  Future<List<Card>> fetchAllCards() async {
    final res = await httpService.request(
      '/payment/method/user/card/many',
      'GET',
      (json) => Card.fromJsonList(json ?? []),
    );

    if (!res.isSuccessful()) throw Exception(res.getError());

    return res.getValue();
  }
}
