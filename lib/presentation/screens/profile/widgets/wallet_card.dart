import 'package:GoDeli/features/user/domain/user.dart';
import 'package:GoDeli/presentation/screens/profile/widgets/wallet_add_funds_modal.dart';
import 'package:flutter/material.dart';

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

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Balance',
              style: textScale.displaySmall,
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
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const WalletAddFundsModal();
                      },
                    );
                  },
                  child: const Text(
                    'Add Funds',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
