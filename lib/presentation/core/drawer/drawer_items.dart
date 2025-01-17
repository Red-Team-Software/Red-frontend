import 'package:flutter/material.dart';

class DrawerItemModel {
  final IconData icon;
  final String title;
  final String? route;

  const DrawerItemModel({required this.icon, required this.title, this.route});
}

class DrawerItems {
  static const categories =
      DrawerItemModel(icon: Icons.category, title: 'All Categories', route: '/categories');
  static const topDeals =
      DrawerItemModel(icon: Icons.local_offer, title: 'Top Deals', route: '/catalog');
  static const language =
      DrawerItemModel(icon: Icons.assignment_rounded, title: 'Languages', route: '/languages');

  static final List<DrawerItemModel> all = [
    categories,
    topDeals,
    language,
  ];
}
