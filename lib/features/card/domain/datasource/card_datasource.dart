import 'package:GoDeli/features/card/domain/card.dart';

abstract class ICardDatasource {
  Future<void> addCard({required String idCard});
  Future<List<Card>> fetchAllCards();
}
