import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/card/domain/card.dart';

abstract class ICardRepository {
  Future<Result<void>> addCard({required String idCard});
  Future<Result<List<Card>>> fetchAllCards();
}
