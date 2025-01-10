import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/payment-method/application/bloc/payment_method_bloc.dart';
import 'package:GoDeli/features/payment-method/domain/payment-method.dart';
import 'package:GoDeli/presentation/screens/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
                  return Padding(
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
                          height: 300,
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
                  );
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  final PaymentMethod paymentMethod;
  const PaymentMethodCard({super.key, required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    final textScale = Theme.of(context).textTheme;

    if (paymentMethod.name.toUpperCase() == 'WALLET') {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: paymentMethod.name.toUpperCase() == 'ZELLE' ||
              paymentMethod.name.toUpperCase() == 'PAGO MOVIL' ||
              paymentMethod.name.toUpperCase() == 'STRIPE'
          ? () {
              showDialog(
                  context: context,
                  builder: (context) {
                    if (paymentMethod.name.toUpperCase() == 'ZELLE') {
                      return ZellePaymentForm();
                    }
                    if (paymentMethod.name.toUpperCase() == 'PAGO MOVIL') {
                      return PagoMovilPaymentForm();
                    }
                    return const SizedBox();
                  });
            }
          : null,
      child: SizedBox(
        height: 100,
        width: 80,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 4,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    Image.network(
                      paymentMethod.imageUrl,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                paymentMethod.name,
                                style: textScale.displayMedium?.copyWith(
                                  color: Colors.white,
                                ),
                              )
                            ]))
                  ],
                ))),
      ),
    );
  }
}

class ZellePaymentForm extends StatelessWidget {
  ZellePaymentForm({super.key});

  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _referenceController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        height: 600,
        width: 300,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Zelle Payment',
                      style: textStyles.displayMedium,
                    ),
                    // Amount Field
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
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Submit'),
                    ),
                                      ],
                ),
              ),
            ),
            Positioned(
                      top: 5,
                      right: 5,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        color: colors.error,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
          ],
        ),
      ),
    ).animate().fadeIn();
  }
}

class PagoMovilPaymentForm extends StatelessWidget {
  PagoMovilPaymentForm({super.key});

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
      child: SizedBox(
        height: 600,
        width: 300,
        child: Stack(
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
                        if (value.length != 11) {
                          return 'Phone must be 11 digits';
                        }
                        if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                          return 'Phone must contain only numbers';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Handle form submission
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: IconButton(
                icon: const Icon(Icons.close),
                color: colors.error,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn();
  }
}
