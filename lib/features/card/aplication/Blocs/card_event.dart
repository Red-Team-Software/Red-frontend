import 'package:GoDeli/features/card/domain/card.dart';

abstract class CardEvent {}

class FetchCards extends CardEvent {}

class CardsLoadedSuccess extends CardEvent {
  final List<Card> cards;

  CardsLoadedSuccess({required this.cards});
}

class CardError extends CardEvent {
  final String error;

  CardError({required this.error});
}

class AddCard extends CardEvent {
  final String idCard;

  AddCard({required this.idCard});
}

class SelectCard extends CardEvent {
  final Card selectedCard;

  SelectCard({required this.selectedCard});
}
