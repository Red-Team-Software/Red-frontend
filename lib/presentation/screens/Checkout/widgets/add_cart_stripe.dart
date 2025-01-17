import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class AddCardScreen extends StatefulWidget {
  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  CardFieldInputDetails? card;
  CardEditController controller = CardEditController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Esto asegura que el contenido no ocupe todo el espacio
        children: [
          CardField(
            onCardChanged: (cardDetails) {
              setState(() {
                card = cardDetails;
              });
            },
          ),
          SizedBox(height: 20),

          
            
          // ElevatedButton(
          //   onPressed: () async {
          //     if (card == null || !card!.complete) {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(content: Text("Por favor completa los datos de la tarjeta.")),
          //       );
          //       return;
          //     }

          //     // Llama al backend para obtener un SetupIntent
          //     // final clientSecret = await fetchSetupIntent();

          //     // Confirma el SetupIntent
          //     final paymentMethod = await Stripe.instance.createPaymentMethod(
          //       params: PaymentMethodParams.card(
          //         paymentMethodData: PaymentMethodData(),
          //       ),
          //     );

          //     // Devuelve el ID de Stripe
          //     print('PaymentMethod ID: ${paymentMethod.id}');
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(content: Text('Tarjeta añadida: ${paymentMethod.id}')),
          //     );

          //     Navigator.of(context).pop(); // Cierra el modal después de añadir la tarjeta
          //   },
          //   child: Text("Añadir Tarjeta"),
          // ),
        ],
      ),
    );
  }
}

  // Future<String> fetchSetupIntent() async {
  //   // Aquí llama a tu API para obtener el clientSecret
  //   final response = await http.post(Uri.parse('TU_API_URL/create-setup-intent'));
  //   final json = jsonDecode(response.body);
  //   return json['clientSecret'];
  // }