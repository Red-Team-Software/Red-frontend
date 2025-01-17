import 'package:GoDeli/features/card/domain/card.dart';

abstract class CardState {}

class CardInitial extends CardState {}

class CardLoadInProgress extends CardState {}

class CardLoadSuccess extends CardState {
  final List<Card> cards;
  final Card? selectedCard;

  CardLoadSuccess({required this.cards, this.selectedCard});
}

class CardLoadFailure extends CardState {
  final String error;

  CardLoadFailure({required this.error});
}
