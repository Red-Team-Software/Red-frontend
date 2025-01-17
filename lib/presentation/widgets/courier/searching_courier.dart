import 'package:flutter/material.dart';

class SearchingCourier extends StatelessWidget {
  const SearchingCourier({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No courier assigned yet',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'We are currently searching for a courier to take your order.',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.search, color: colors.primary, size: 30),
          ],
        ),
      ),
    );
  }
}
