import 'dart:async';

import 'package:GoDeli/presentation/widgets/dot_list/custom_dots_list.dart';
import 'package:flutter/material.dart';

class HomeBannerCarrousel extends StatefulWidget {
  final List<String> cards = [
    'images/banner_red_alessandro.jpg',
    'images/banner_red_alfredo.jpg',
    // 'images/red_banner_bryant.jpg',
    'images/banner_red_daniel.jpg',
    // 'images/red_banner_eduardo.jpg',
    'images/banner_red_gabriel.jpg',
  ];

  HomeBannerCarrousel({
    super.key,
  });

  @override
  State<HomeBannerCarrousel> createState() => _HomeBannerCarrouselState();
}

class _HomeBannerCarrouselState extends State<HomeBannerCarrousel> {
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
            width: 450,
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.cards.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return BannerCard(assetImage: AssetImage(widget.cards[index]));
              },
            ),
          ),
        ]),
        const SizedBox(height: 12),
        CustomDotsList(
            currentPage: _currentPage, theme: theme, list: widget.cards),
      ],
    );
  }
}

class BannerCard extends StatelessWidget {
  final AssetImage assetImage;
  const BannerCard({super.key, required this.assetImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: 
        SizedBox(
          height: 300,
          width: 450,
          // width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 450/300,
              child: Stack(children: [
                Image(
                  image: assetImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 40,
                      ),
                    );
                  },
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
                                  Color.fromARGB(100, 0, 0,
                                      0), // Oscuro en el borde izquierdo
                                  Colors
                                      .transparent, // Transparente hacia el centro
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
                                  Color.fromARGB(
                                      100, 0, 0, 0), // Oscuro en el borde derecho
                                  Colors
                                      .transparent, // Transparente hacia el centro
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
            ),
          ),
        ),
      ),
    );
  }
}
