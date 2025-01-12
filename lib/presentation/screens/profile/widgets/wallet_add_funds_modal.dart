import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/payment-method/application/bloc/payment_method_bloc.dart';
import 'package:GoDeli/presentation/screens/profile/widgets/wallet/payment_method_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletAddFundsModal extends StatefulWidget {
  const WalletAddFundsModal({super.key});

  @override
  State<WalletAddFundsModal> createState() => _WalletAddFundsModalState();
}

class _WalletAddFundsModalState extends State<WalletAddFundsModal> {
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return BlocProvider(
      create: (_) => getIt<PaymentMethodBloc>(),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          height: 600,
          width: 300,
          child: BlocConsumer<PaymentMethodBloc, PaymentMethodState>(
              listener: (context, state) => {
                    if (state is PaymentMethodError)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        )
                      }
                  },
              builder: (context, state) {
                if (state is PaymentMethodError) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                if (state is PaymentMethodLoaded) {
                  return Stack(children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Add Funds',
                            style: textStyles.displayMedium,
                          ),
                          const SizedBox(height: 20),
                          // Listado de métodos de pago
                          Container(
                            height: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                if (state.paymentMethods.isEmpty) {
                                  return const Center(
                                    child: Text('No payment methods'),
                                  );
                                }
                                return PaymentMethodCard(
                                    paymentMethod: state.paymentMethods[index]);
                              },
                              itemCount: state.paymentMethods.length,
                              padding: const EdgeInsets.all(8),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        color: colors.error,
                        onPressed: () {
                          Navigator.pop(context, null);
                        },
                      ),
                    )
                  ]);
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }
}
