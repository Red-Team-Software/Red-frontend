import 'package:GoDeli/features/bundles/application/bundles/all_bundles_bloc.dart';
import 'package:GoDeli/presentation/widgets/dot_list/custom_dots_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class CardBundleCarrusel extends StatefulWidget {
  const CardBundleCarrusel({super.key});

  @override
  State<CardBundleCarrusel> createState() => _CardBundleCarruselState();
}

class _CardBundleCarruselState extends State<CardBundleCarrusel> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.7, initialPage: 1);

    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (_currentPage != page) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = theme.textTheme;

    return SizedBox(
        height: 600, // Ajusta la altura según tus necesidades
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título y botón "view all"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Bundle Offers', style: textStyles.displayLarge),
                  GestureDetector(
                    onTap: () => context.push('/catalog'),
                    child: Text(
                      'view all',
                      textAlign: TextAlign.end,
                      style: textStyles.displaySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // BlocBuilder para los bundles
            Expanded(
              child: BlocBuilder<AllBundlesBloc, AllBundlesState>(
                builder: (context, state) {
                  if (state.status == BundlesStatus.loading &&
                      state.bundles.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.bundles.isEmpty &&
                      (state.status == BundlesStatus.allLoaded ||
                          state.status == BundlesStatus.loaded)) {
                    return const Center(
                      child: Text(
                        'Algo raro pasó, ¡No hay Bundles!',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  if (state.status == BundlesStatus.error) {
                    return Center(
                      child: Text(
                        'Algo inesperado pasó',
                        style: textStyles.bodyLarge?.copyWith(
                          color: theme.colorScheme.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  // PageView con los Bundles
                  return Column(
                    children: [
                      SizedBox(
                        height: 370, // Ajusta la altura según los bundles
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: state.bundles.length,
                          itemBuilder: (BuildContext context, int index) {
                            final currentBundle = state.bundles[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: BundleHomeCard(current: currentBundle),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Puntos indicadores
                     CustomDotsList(currentPage: _currentPage, theme: theme, list: state.bundles),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
    );
  }
}

