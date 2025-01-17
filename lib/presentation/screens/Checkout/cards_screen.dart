import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/card/domain/repositories/card_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/features/card/aplication/Blocs/card_bloc.dart';
import 'package:GoDeli/features/card/aplication/Blocs/card_event.dart';
import 'package:GoDeli/features/card/aplication/Blocs/card_state.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CardBloc(cardRepository: getIt<ICardRepository>())..add(FetchCards()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Cards'),
        ),
        body: BlocBuilder<CardBloc, CardState>(
          builder: (context, state) {
            if (state is CardLoadInProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CardLoadSuccess) {
              if (state.cards.isEmpty) {
                return const Center(child: Text('No cards available.'));
              }
              return ListView.builder(
                itemCount: state.cards.length,
                itemBuilder: (context, index) {
                  final card = state.cards[index];
                  return ListTile(
                    title: Text('${card.brand} **** ${card.last4}'),
                    subtitle: Text('Expires ${card.expMonth}/${card.expYear}'),
                    selected: state.selectedCard == card,
                    onTap: () {
                      context
                          .read<CardBloc>()
                          .add(SelectCard(selectedCard: card));
                    },
                  );
                },
              );
            } else if (state is CardLoadFailure) {
              return Center(
                  child: Text('Failed to load cards: ${state.error}'));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}
