import 'package:GoDeli/features/common/domain/result.dart';
import 'package:GoDeli/features/card/domain/card.dart';
import 'package:GoDeli/features/card/domain/repositories/card_repository.dart';
import 'package:GoDeli/features/card/domain/datasource/card_datasource.dart';

class CardRepositoryImpl implements ICardRepository {
  final ICardDatasource datasource;

  CardRepositoryImpl({required this.datasource});

  @override
  Future<Result<void>> addCard({required String idCard}) async {
    try {
      await datasource.addCard(idCard: idCard);
      return Result.success(null);
    } catch (e) {
      print("Error adding card: $e");
      return Result.makeError(Exception(e));
    }
  }

  @override
  Future<Result<List<Card>>> fetchAllCards() async {
    try {
      final cards = await datasource.fetchAllCards();
      return Result.success(cards);
    } catch (e) {
      print("Error fetching cards: $e");
      return Result.makeError(Exception(e));
    }
  }
}
