// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:go_delivery_frontend/application/BLoc/blocs.dart';
// import 'package:go_delivery_frontend/application/BLoc/payment/card/card_event.dart';
// import 'package:go_delivery_frontend/application/BLoc/payment/card/card_state.dart';
// import 'package:go_delivery_frontend/application/BLoc/payment/card_get/get_card_event.dart';

// class PaymentCardScreen extends StatefulWidget {
//   const PaymentCardScreen({super.key});

//   @override
//   AddCardScreenState createState() => AddCardScreenState();
// }

// class AddCardScreenState extends State<PaymentCardScreen> {
//   CardFieldInputDetails? _cardDetails;
//   Future<void> _saveCard(BuildContext context) async {
//     if (_cardDetails == null || !_cardDetails!.complete) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text("Por favor, completa los datos de la tarjeta")),
//       );
//       return;
//     }

//     try {
//       final paymentMethod = await Stripe.instance.createPaymentMethod(
//         params: const PaymentMethodParams.card(
//           paymentMethodData: PaymentMethodData(
//             billingDetails: BillingDetails(name: 'Nombre del titular'),
//           ),
//         ),
//       );

//       final cardId = paymentMethod.id;

//       print('Tarjeta creada con ID: $cardId');
//       BlocProvider.of<CardBloc>(context).add(SubmitCardPayment(idCard: cardId));
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error al añadir la tarjeta: $e")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF2000B1),
//         title: const Text(
//           'Añadir tarjeta.',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CardField(
//               onCardChanged: (card) {
//                 setState(() {
//                   _cardDetails = card;
//                 });
//               },
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: "Tarjeta de crédito/débito",
//               ),
//             ),
//             const SizedBox(height: 20),
//             BlocListener<CardBloc, CardState>(
//               listener: (context, state) {
//                 if (state is PaymentLoading) {
//                   showDialog(
//                     context: context,
//                     barrierDismissible: false,
//                     builder: (context) =>
//                         const Center(child: CircularProgressIndicator()),
//                   );
//                 } else {
//                   Navigator.pop(context);

//                   if (state is PaymentSuccess) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                           content: Text("¡Tarjeta añadida con éxito!")),
//                     );
//                   } else if (state is PaymentFailure) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("Error: ${state.message}")),
//                     );
//                   }
//                   BlocProvider.of<CardListBloc>(context).add(LoadCardList());
//                   Navigator.pop(context);
//                 }
//               },
//               child: Center(
//                 child: ElevatedButton(
//                   onPressed: () => _saveCard(context),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF2000B1),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     minimumSize: const Size(200, 50),
//                   ),
//                   child: const Text(
//                     "Guardar tarjeta",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
