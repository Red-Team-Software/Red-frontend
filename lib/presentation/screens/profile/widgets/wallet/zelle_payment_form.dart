import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/wallet/application/bloc/wallet_bloc.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:GoDeli/presentation/screens/profile/widgets/wallet/wallet_custom_close_button.dart';
import 'package:GoDeli/presentation/widgets/snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ZellePaymentForm extends StatelessWidget {
  final String paymentId;
  ZellePaymentForm({super.key, required this.paymentId});

  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _referenceController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final language = context.watch<LanguagesCubit>().state.selected.language;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<WalletBloc>()),
        ],
        child: BlocListener<WalletBloc, WalletState>(
          listener: (context, state) {
            if (state is PayingSuccess) {
              CustomSnackBar.show(
                context,
                message: 'Payment successful',
                type: SnackBarType.success,
                title: 'Success',
              );
              
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
              builder: (context, walletState) {
                if (walletState is Paying) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (walletState is PayingError) {
                  return Stack(children: [
                    Center(
                      child: Text(walletState.message),
                    ),
                    WalletCustomCloseButton(colors: colors),
                  ]);
                }
                return Stack(children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TranslationWidget(
                              message: 'Zelle Payment',
                              toLanguage: language,
                              builder: (translated) => Text(translated,
                                  style: textStyles.displayMedium)),
                          TextFormField(
                            controller: _amountController,
                            decoration: InputDecoration(
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
                          // Reference Field
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
                          // Email Field
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email';
                              }
                              if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                                  .hasMatch(value)) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Handle form submission
                                context.read<WalletBloc>().add(PayZelle(
                                    amount:
                                        double.parse(_amountController.text),
                                    email: _emailController.text,
                                    reference: _referenceController.text,
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
                ]);
              },
            ),
          ),
        ),
      ),
    ).animate().fadeIn();
  }
}
