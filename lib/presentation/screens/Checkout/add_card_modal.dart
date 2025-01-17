import 'package:GoDeli/presentation/widgets/snackbar/custom_snackbar.dart';
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
    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      child: SizedBox(
        height: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Add Card",
              style: textStyles.displaySmall,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      8.0), // Bordes redondeados opcionales
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colors.secondary,
                    width: 2.0, // Grosor del borde
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors
                        .orange, // Color del borde cuando el campo está enfocado
                    width: 2.0, // Grosor del borde
                  ),
                ),
                icon: const Icon(Icons.person),
                labelText: "Cardholder Name",
                labelStyle: const TextStyle(
                  color: Colors.grey, // Color de la etiqueta
                ),
              ),
              cursorColor: Colors.orange, // Color del cursor
            ),
            const SizedBox(height: 20),
            CardField(
              onCardChanged: (card) {
                setState(() {
                  _cardDetails = card;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      8.0), // Bordes redondeados opcionales
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colors.secondary,
                    width: 2.0, // Grosor del borde
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors
                        .orange, // Color del borde cuando el campo está enfocado
                    width: 2.0, // Grosor del borde
                  ),
                ),
                icon: const Icon(Icons.credit_card),
                labelText: "Credit/Debit Card",
                labelStyle: const TextStyle(
                  color: Colors.grey, // Color de la etiqueta
                ),
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
                    CustomSnackBar.show(
                      context,
                      type: SnackBarType.success,
                      title: "Success",
                      message: "Card added successfully!",
                    );
                  } else if (state is CardLoadFailure) {
                    CustomSnackBar.show(
                      context,
                      type: SnackBarType.error,
                      title: "Error",
                      message: state.error,
                    );
                  }
                  Navigator.pop(context);
                }
              },
              child: Center(
                child: ElevatedButton(
                  onPressed: () => _saveCard(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(200, 50),
                  ),
                  child: Text(
                    "Save Card",
                    style: textStyles.displaySmall?.copyWith(
                      color: colors.primary)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
