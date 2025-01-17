import 'dart:async';

import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/common/application/bloc/select_datasource_bloc_bloc.dart';
import 'package:GoDeli/presentation/widgets/dot_list/custom_dots_list.dart';
import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';

class HomeBannerCarrousel extends StatefulWidget {

  final SelectDatasourceBloc selectDatasourceBloc = getIt<SelectDatasourceBloc>();

  final List<String> redCards = [
    'images/banner_red_alessandro.jpg',
    'images/banner_red_alfredo.jpg',
    // 'images/red_banner_bryant.jpg',
    'images/banner_red_daniel.jpg',
    // 'images/red_banner_eduardo.jpg',
    'images/banner_red_gabriel.jpg',
  ];

  final List<String> blueCards = [
    'images/banner_blue_estefany.jpg',
    'images/banner_blue_christian.jpg',
    'images/banner_blue_gustavo.jpg',
  ];


  HomeBannerCarrousel({
    
    super.key,
  });

  @override
  State<HomeBannerCarrousel> createState() => _HomeBannerCarrouselState();
}

class _HomeBannerCarrouselState extends State<HomeBannerCarrousel> {
  late PageController _pageController;
  late List<String> cards;
  int _currentPage = 0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    cards = widget.selectDatasourceBloc.state.isRed == true ? widget.redCards : widget.blueCards;

    // Configura un temporizador para cambiar automáticamente cada 10 segundos
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (_currentPage < cards.length - 1) {
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
            height: 250,
            width: 450,
            child: PageView.builder(
              controller: _pageController,
              itemCount: cards.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return BannerCard(assetImage: AssetImage(cards[index]));
              },
            ),
          ),
        ]),
        const SizedBox(height: 12),
        CustomDotsList(
            currentPage: _currentPage, theme: theme, list: cards),
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
