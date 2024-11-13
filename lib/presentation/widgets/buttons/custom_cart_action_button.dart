import 'package:flutter/material.dart';

class CustomCartActionButton extends StatelessWidget {
  const CustomCartActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(2.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.remove,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          Text(
            '1',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
