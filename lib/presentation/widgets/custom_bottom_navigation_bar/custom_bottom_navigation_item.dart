import 'package:flutter/material.dart';

class CustomBottomNavigationItem extends StatelessWidget {
  const CustomBottomNavigationItem(
      {super.key,
      required this.icon,
      required this.activeIcon,
      required this.name,
      required this.isActive,
      this.onTap});

  final Widget icon;
  final Widget activeIcon;
  final String name;
  final bool isActive;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
