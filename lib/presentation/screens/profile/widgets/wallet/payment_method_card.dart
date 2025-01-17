
import 'package:GoDeli/features/payment-method/domain/payment-method.dart';
import 'package:GoDeli/features/search/application/bloc/bloc.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:GoDeli/presentation/screens/profile/widgets/wallet/pago_movil_payment_form.dart';
import 'package:GoDeli/presentation/screens/profile/widgets/wallet/zelle_payment_form.dart';
import 'package:flutter/material.dart';

class PaymentMethodCard extends StatelessWidget {
  final PaymentMethod paymentMethod;
  const PaymentMethodCard({super.key, required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
    final textScale = Theme.of(context).textTheme;
    final language =  context.watch<LanguagesCubit>().state.selected.language;


    if (paymentMethod.name.toUpperCase() == 'WALLET') {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: paymentMethod.name.toUpperCase() == 'ZELLE' ||
              paymentMethod.name.toUpperCase() == 'PAGO MOVIL' ||
              paymentMethod.name.toUpperCase() == 'STRIPE'
          ? () async {
              final amount = await showDialog<double>(
                  context: context,
                  builder: (context) {
                    if (paymentMethod.name.toUpperCase() == 'ZELLE') {
                      return ZellePaymentForm(paymentId: paymentMethod.id);
                    }
                    if (paymentMethod.name.toUpperCase() == 'PAGO MOVIL') {
                      return PagoMovilPaymentForm(paymentId: paymentMethod.id);
                    }
                    return const SizedBox();
                  });
              // Devolver el valor a WalletAddFundsModal
              if (amount != null && amount > 0) {
                Navigator.pop(context, amount);
              }
            }
          : null,
      child: SizedBox(
        height: 120,
        width: 80,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 8,
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
                              TranslationWidget(
                                message: paymentMethod.name,
                                toLanguage: language,
                                builder: (translated) => Text(
                                  translated,
                                  style: textScale.displayMedium?.copyWith(
                                    color: Colors.white,
                                  )
                                )
                              )
                            ]))
                  ],
                ))),
      ),
    );
  }
}
