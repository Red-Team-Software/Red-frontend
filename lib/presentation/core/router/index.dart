import 'package:GoDeli/presentation/screens/Home/home_screen.dart';
import 'package:GoDeli/presentation/screens/profile/profile_screen.dart';
import 'package:GoDeli/presentation/screens/Search/search.dart';
import 'package:GoDeli/presentation/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:GoDeli/presentation/widgets/custom_bottom_navigation_bar/custom_bottom_navigation_item.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});
  static const String name = 'index_screen';
  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _pageIndex = 0;

  final pages = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen(),
    const ProfileScreen(),
  ];

  late final List<CustomBottomNavigationItem> _items = [
    CustomBottomNavigationItem(
      icon: const Icon(Icons.home_rounded),
      activeIcon: const Icon(Icons.home_outlined),
      isActive: _pageIndex == 0,
      name: "Home",
    ),
    CustomBottomNavigationItem(
      icon: const Icon(Icons.search_rounded),
      activeIcon: const Icon(Icons.search_outlined),
      isActive: _pageIndex == 1,
      name: "Search",
    ),
    CustomBottomNavigationItem(
      icon: const Icon(Icons.menu_book_sharp),
      activeIcon: const Icon(Icons.menu_book_outlined),
      isActive: _pageIndex == 2,
      name: "Perfil",
    ),
    CustomBottomNavigationItem(
      icon: const Icon(Icons.menu_rounded),
      activeIcon: const Icon(Icons.menu_outlined),
      isActive: _pageIndex == 3,
      name: "Menu",
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_pageIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        items1: _items.sublist(0, 2), // Primera mitad de los elementos
        items2: _items.sublist(2), // Segunda mitad de los elementos
        currentIndex: _pageIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
