import 'package:flutter/material.dart';

class CustomDotsList extends StatelessWidget {
  const CustomDotsList({
    super.key,
    required int currentPage,
    required this.theme,
    required this.list,
  }) : _currentPage = currentPage;

  final int _currentPage;
  final ThemeData theme;
  final List<dynamic> list;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(list.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 24 : 8, // Tamaño dinámico
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? theme.colorScheme.primary
                : Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}