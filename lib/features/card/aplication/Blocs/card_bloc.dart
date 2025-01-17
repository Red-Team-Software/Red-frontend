import 'package:bloc/bloc.dart';
import 'package:GoDeli/features/card/domain/repositories/card_repository.dart';
import 'card_event.dart';
import 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final ICardRepository cardRepository;

  CardBloc({required this.cardRepository}) : super(CardInitial()) {
    on<FetchCards>(_onFetchCards);
    on<AddCard>(_onAddCard);
    on<SelectCard>(_onSelectCard);
  }

  void _onFetchCards(FetchCards event, Emitter<CardState> emit) async {
    emit(CardLoadInProgress());
    try {
      final result = await cardRepository.fetchAllCards();
      if (result.isSuccessful()) {
        emit(CardLoadSuccess(cards: result.getValue()));
      } else {
        emit(CardLoadFailure(error: 'Failed to load cards'));
      }
    } catch (e) {
      emit(CardLoadFailure(error: e.toString()));
    }
  }

  void _onAddCard(AddCard event, Emitter<CardState> emit) async {
    emit(CardLoadInProgress());
    try {
      final result = await cardRepository.addCard(idCard: event.idCard);

      print("Resultado de l add card bloc");
      print(result.isSuccessful());

      if (result.isSuccessful()) {
        final fetchResult = await cardRepository.fetchAllCards();
        print("Resultado de l add card trayendo bloc");
        print(fetchResult.isSuccessful());
        print(fetchResult.getValue());

        if (fetchResult.isSuccessful()) {
          emit(CardLoadSuccess(cards: fetchResult.getValue()));
        } else {
          emit(CardLoadFailure(error: 'Failed to load cards after adding'));
        }
      } else {
        emit(CardLoadFailure(error: 'Failed to add card'));
      }
    } catch (e) {
      emit(CardLoadFailure(error: e.toString()));
    }
  }

  void _onSelectCard(SelectCard event, Emitter<CardState> emit) {
    if (state is CardLoadSuccess) {
      final currentState = state as CardLoadSuccess;
      emit(CardLoadSuccess(
          cards: currentState.cards, selectedCard: event.selectedCard));
    }
  }
}
