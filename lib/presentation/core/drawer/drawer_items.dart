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
  static const makeRequest =
      DrawerItemModel(icon: Icons.request_page, title: 'Make product request');
  static const track =
      DrawerItemModel(icon: Icons.gps_fixed_rounded, title: 'Track your Order');
  static const cupons =
      DrawerItemModel(icon: Icons.card_giftcard, title: 'Cupons');

  static final List<DrawerItemModel> all = [
    categories,
    topDeals,
    makeRequest,
    track,
    cupons,
  ];
}
