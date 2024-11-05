import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationDecoration extends StatelessWidget {
  final Size size;
  final int currentIndex;

  void onItemTapped(BuildContext context, int index) {}

  const BottomNavigationDecoration(
      {super.key, required this.size, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      width: size.width,
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _CustomeIconButton(
            icon: Icons.home_rounded,
            activeIcon: Icons.home_outlined,
            index: 0,
            colors: colors,
            currentIndex: currentIndex,
            onItemTapped: onItemTapped,
            label: 'Home',
          ),
          _CustomeIconButton(
            icon: Icons.search_rounded,
            activeIcon: Icons.search_outlined,
            index: 1,
            colors: colors,
            currentIndex: currentIndex,
            onItemTapped: onItemTapped,
            label: 'Search',
          ),
          Container(
            width: size.width * 0.20,
          ),
          _CustomeIconButton(
            icon: Icons.menu_book_sharp,
            activeIcon: Icons.menu_book_outlined,
            index: 2,
            colors: colors,
            currentIndex: currentIndex,
            onItemTapped: onItemTapped,
            label: 'Perfil',
          ),
          _CustomeIconButton(
            icon: Icons.menu_rounded,
            activeIcon: Icons.menu_outlined,
            index: 3,
            colors: colors,
            currentIndex: currentIndex,
            onItemTapped: onItemTapped,
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}

class _CustomeIconButton extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final int index;
  final int currentIndex;
  final ColorScheme colors;
  final String label;
  final void Function(BuildContext context, int index) onItemTapped;

  const _CustomeIconButton(
      {required this.icon,
      required this.activeIcon,
      required this.index,
      required this.colors,
      required this.currentIndex,
      required this.onItemTapped,
      required this.label});

  @override
  Widget build(BuildContext context) {
    final isSelected = currentIndex == index;

    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => onItemTapped(context, index),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color:
                  currentIndex == index ? colors.primary : Colors.transparent,
              width: 6.0,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected
                  ? colors.primary
                  : theme.brightness == Brightness.dark
                      ? Colors.white24
                      : Colors.black26,
              size: 40.0,
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? colors.primary
                    : theme.brightness == Brightness.dark
                        ? Colors.white24
                        : Colors.black26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
