import 'package:GoDeli/presentation/screens/Checkout/add_card_modal.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/features/card/aplication/Blocs/card_bloc.dart';
import 'package:GoDeli/features/card/aplication/Blocs/card_event.dart';
import 'package:GoDeli/features/card/aplication/Blocs/card_state.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  _CardsScreenState createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CardBloc>().add(FetchCards());
  }

  void _openAddCardModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const AddCardModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cards'),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CardBloc, CardState>(
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
                        subtitle:
                            Text('Expires ${card.expMonth}/${card.expYear}'),
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
                } else if (state is CardInitial) {
                  return const Center(child: Text('Initializing...'));
                } else {
                  print('Unknown state: $state');
                  return const Center(child: Text('Unknown state'));
                }
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => _openAddCardModal(context),
              style: ElevatedButton.styleFrom(
                minimumSize:
                    const Size(double.infinity, 36), // Full width button
              ),
              child: const Text('Add Card'),
            ),
          ),
        ],
      ),
    );
  }
}
