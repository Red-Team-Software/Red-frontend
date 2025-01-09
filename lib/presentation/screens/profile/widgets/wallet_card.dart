import 'package:GoDeli/features/user/domain/user.dart';
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
    final theme = Theme.of(context);
    final textScale = theme.textTheme;

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
              'Tu saldo',
              style: TextStyle(
                fontSize: textScale.displaySmall?.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${widget.wallet.currency.toUpperCase()}. ',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.wallet.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Recargar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    ;
  }
}
