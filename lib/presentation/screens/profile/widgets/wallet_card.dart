import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/user/application/bloc/user_bloc.dart';
import 'package:GoDeli/features/user/domain/user.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:GoDeli/presentation/screens/profile/widgets/wallet_add_funds_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletCard extends StatefulWidget {
  final Wallet wallet;
  const WalletCard({super.key, required this.wallet});

  @override
  State<WalletCard> createState() => _WalletCardState();
}

class _WalletCardState extends State<WalletCard> {
  @override
  Widget build(BuildContext context) {
    final textScale = Theme.of(context).textTheme;
    final language =  context.watch<LanguagesCubit>().state.selected.language;

    return BlocProvider(
      create: (_) => getIt<UserBloc>(),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TranslationWidget(
                message: 'Your Balance',
                toLanguage: language,
                builder: (translated) => Text(
                    translated,
                    style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)
                ), 
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '${widget.wallet.currency.toUpperCase()}. ',
                    style: textScale.displayMedium,
                  ),
                  Text(
                    '${widget.wallet.amount}',
                    style: textScale.displayMedium,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      final amount = await showDialog<double>(
                        context: context,
                        builder: (BuildContext context) {
                          return const WalletAddFundsModal();
                        },
                      );

                      if (amount != null && amount > 0) {
                        setState(() {
                          // Actualizar el valor en el widget
                          context.read<UserBloc>().add(GetUserEvent());
                          widget.wallet.amount += amount;
                        });
                      }
                    },
                    child: 
                    TranslationWidget(
                      message: 'Add Funds',
                      toLanguage: language,
                      builder: (translated) => Text(
                          translated,
                          style: const TextStyle(fontWeight: FontWeight.bold)
                      ), 
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
