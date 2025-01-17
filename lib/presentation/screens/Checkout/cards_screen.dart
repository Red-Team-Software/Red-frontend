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
    final textStyles = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cards',
          style: textStyles.displayLarge,
        ),
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
                      return CardCatalogItem(
                          brand: card.brand,
                          last4: card.last4,
                          expMonth: card.expMonth,
                          expYear: card.expYear,
                          isSelected: state.selectedCard == card,
                          onTap: () {
                            context
                                .read<CardBloc>()
                                .add(SelectCard(selectedCard: card));
                          });
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () => _openAddCardModal(context),
                style: ElevatedButton.styleFrom(
                  // minimumSize: const Size(200, 75),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Text('Add Card', style: textStyles.displaySmall),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardCatalogItem extends StatelessWidget {
  final String brand;
  final String last4;
  final int expMonth;
  final int expYear;
  final bool isSelected;
  final VoidCallback onTap;

  const CardCatalogItem({
    Key? key,
    required this.brand,
    required this.last4,
    required this.expMonth,
    required this.expYear,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSelected ? colors.primary : Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.credit_card,
              color: isSelected ? Colors.blue : Colors.grey.shade600,
              size: 40.0,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$brand **** $last4',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.blue : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Expires $expMonth/$expYear',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: colors.primary,
                size: 24.0,
              ),
          ],
        ),
      ),
    );
  }
}
