import 'dart:async';

import 'package:GoDeli/presentation/screens/Home/home_screen.dart';
import 'package:GoDeli/presentation/widgets/dot_list/custom_dots_list.dart';
import 'package:flutter/material.dart';

class HomaBannerCarrousel extends StatefulWidget {
  final List<String> cards = [
    'images/banner1.jpg',
    'images/banner2.jpg',
    'images/banner3.jpg',
  ];


  HomaBannerCarrousel({
    super.key,
  });

  @override
  State<HomaBannerCarrousel> createState() => _HomaBannerCarrouselState();
}

class _HomaBannerCarrouselState extends State<HomaBannerCarrousel> {
  late PageController _pageController;

  int _currentPage = 0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);

    // Configura un temporizador para cambiar automáticamente cada 10 segundos
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (_currentPage < widget.cards.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancela el temporizador cuando se destruye el widget
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Stack(children: [
          SizedBox(
            height: 300,
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: const [
                Image(
                  image: AssetImage('images/banner1.jpg'),
                  fit: BoxFit.cover,
                ),
                Image(
                  image: AssetImage('images/banner2.jpg'),
                  fit: BoxFit.cover,
                ),
                Image(
                  image: AssetImage('images/banner3.jpg'),
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              ignoring: true,
              child: Row(
                children: [
                  // Gradiente izquierdo
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color.fromARGB(100, 0, 0, 0), // Oscuro en el borde izquierdo
                            Colors.transparent, // Transparente hacia el centro
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Gradiente derecho
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [
                            Color.fromARGB(100, 0, 0, 0),  // Oscuro en el borde derecho
                            Colors.transparent, // Transparente hacia el centro
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
        const SizedBox(height: 12),
        CustomDotsList(currentPage: _currentPage, theme: theme, list: widget.cards),
      ],
    );
  }
}