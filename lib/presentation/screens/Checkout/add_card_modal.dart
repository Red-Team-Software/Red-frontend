import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:GoDeli/features/card/aplication/Blocs/card_bloc.dart';
import 'package:GoDeli/features/card/aplication/Blocs/card_event.dart';
import 'package:GoDeli/features/card/aplication/Blocs/card_state.dart';

class AddCardModal extends StatefulWidget {
  const AddCardModal({super.key});

  @override
  _AddCardModalState createState() => _AddCardModalState();
}

class _AddCardModalState extends State<AddCardModal> {
  CardFieldInputDetails? _cardDetails;
  final TextEditingController _nameController = TextEditingController();

  Future<void> _saveCard(BuildContext context) async {
    print("Card details: $_cardDetails");
    print("Card details complete: ${_cardDetails!.complete}");

    if (_cardDetails == null || !_cardDetails!.complete) {
      print("Card details are incomplete");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete the card details")),
      );
      return;
    }

    try {
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(name: _nameController.text),
          ),
        ),
      );

      final cardId = paymentMethod.id;

      print('Card created with ID: $cardId');
      BlocProvider.of<CardBloc>(context).add(AddCard(idCard: cardId));
    } catch (e, stacktrace) {
      print(e);
      print("stacktrace");
      print(stacktrace);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Cardholder Name",
            ),
          ),
          const SizedBox(height: 20),
          CardField(
            onCardChanged: (card) {
              setState(() {
                _cardDetails = card;
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Credit/Debit Card",
            ),
          ),
          const SizedBox(height: 20),
          BlocListener<CardBloc, CardState>(
            listener: (context, state) {
              if (state is CardLoadInProgress) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) =>
                      const Center(child: CircularProgressIndicator()),
                );
              } else {
                Navigator.pop(context);

                if (state is CardLoadSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Card added successfully!")),
                  );
                } else if (state is CardLoadFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: ${state.error}")),
                  );
                }
                Navigator.pop(context);
              }
            },
            child: Center(
              child: ElevatedButton(
                onPressed: () => _saveCard(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2000B1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(200, 50),
                ),
                child: const Text(
                  "Save Card",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
