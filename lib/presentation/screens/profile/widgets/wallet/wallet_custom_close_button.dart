import 'package:flutter/material.dart';

class WalletCustomCloseButton extends StatelessWidget {
  const WalletCustomCloseButton({
    super.key,
    required this.colors,
  });

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5,
      right: 5,
      child: IconButton(
        icon: const Icon(Icons.close),
        color: colors.error,
        onPressed: () {
          Navigator.pop(context, null);
        },
      ),
    );
  }
}
