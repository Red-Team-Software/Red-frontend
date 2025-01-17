import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/user/application/bloc/user_bloc.dart';
import 'package:GoDeli/features/wallet/application/bloc/wallet_bloc.dart';
import 'package:GoDeli/presentation/screens/profile/widgets/wallet/wallet_custom_close_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PagoMovilPaymentForm extends StatelessWidget {
  final String paymentId;
  PagoMovilPaymentForm({super.key, required this.paymentId});

  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _referenceController = TextEditingController();
  final _bankController = TextEditingController();
  final _identificationController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<WalletBloc>()),
            BlocProvider(create: (_) => getIt<UserBloc>()),
          ],
          child: BlocListener<WalletBloc, WalletState>(
            listener: (context, state) {
              if (state is PayingSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Payment successful'),
                  backgroundColor: colors.primary,
                ),
              );
              print('PagoMovilPaymentForm: ${state.amount}');
              Navigator.pop(context, state.amount);
              context.read<WalletBloc>().add(Reset());
            }

            if (state is PayingError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: colors.error,
                ),
              );
            }
            },
            child: SizedBox(
                height: 600,
                width: 300,
                child: BlocBuilder<WalletBloc, WalletState>(
                    builder: (context, state) {
                  if (state is Paying) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is PayingError) {
                    return Stack(children: [
                      Center(
                        child: Text(state.message),
                      ),
                      WalletCustomCloseButton(colors: colors),
                    ]);
                  }
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'Pago Movil Payment',
                                style: textStyles.displayMedium,
                              ),
                              TextFormField(
                                controller: _amountController,
                                decoration: InputDecoration(
                                  focusColor: colors.primary,
                                  labelText: 'Amount',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an amount';
                                  }
                                  final amount = double.tryParse(value);
                                  if (amount == null || amount <= 0) {
                                    return 'Enter a valid amount';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _referenceController,
                                decoration: InputDecoration(
                                  labelText: 'Reference',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a reference';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _bankController,
                                decoration: InputDecoration(
                                  labelText: 'Bank',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the bank name';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _identificationController,
                                decoration: InputDecoration(
                                  labelText: 'Identification',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your identification';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _phoneController,
                                decoration: InputDecoration(
                                  labelText: 'Phone',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your phone number';
                                  }
                                  if (value.length != 12) {
                                    return 'Phone must be 11 digits';
                                  }
                                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                    return 'Phone must contain only numbers';
                                  }
                                  return null;
                                },
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    // Handle form submission
                                    context.read<WalletBloc>().add(PayPagoMovil(
                                        amount: double.parse(
                                            _amountController.text),
                                        phone: _phoneController.text,
                                        reference: _referenceController.text,
                                        bank: _bankController.text,
                                        identification:
                                            _identificationController.text,
                                        paymentId: paymentId));
                                  }
                                },
                                child: const Text('Submit'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      WalletCustomCloseButton(colors: colors),
                    ],
                  );
                })),
          ),
        ));
  }
}
