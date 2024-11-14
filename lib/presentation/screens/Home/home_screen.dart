import 'package:GoDeli/features/bundles/application/bundles/all_bundles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:GoDeli/features/products/application/products/all_products_bloc.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/features/categories/application/categories_bloc.dart';
import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/presentation/widgets/widgets.dart';
import 'package:GoDeli/presentation/screens/Home/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const String name = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double xOffset;
  late double yOffset;
  late double scaleFactor;
  bool isDragging = false;
  late bool isDrawerOpen;

  @override
  void initState() {
    super.initState();

    closeDrawer();
  }

  void openDrawer() => setState(() {
        xOffset = 230;
        yOffset = 150;
        scaleFactor = 0.6;
        isDrawerOpen = true;
      });

  void closeDrawer() => setState(() {
        xOffset = 0;
        yOffset = 0;
        scaleFactor = 1;
        isDrawerOpen = false;
      });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              const Color.fromRGBO(70, 3, 18, 1),
            ],
          ),
        ),
        child: Stack(children: [buildDrawer(), buildPage()]));
  }

  Widget buildPage() {
    return GestureDetector(
      onTap: closeDrawer,
      onHorizontalDragStart: (details) => isDragging = true,
      onHorizontalDragUpdate: (details) {
        if (!isDragging) return;
        const delta = 1;
        if (details.delta.dx > delta) {
          openDrawer();
        } else if (details.delta.dx < -delta) {
          closeDrawer();
        }

        isDragging = false;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor),
        child: AbsorbPointer(
            absorbing: isDrawerOpen,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(isDrawerOpen ? 24 : 0),
                  color: isDrawerOpen
                      ? Colors.white70
                      : Theme.of(context).scaffoldBackgroundColor,
                ),
                child: HomeScreenView(openDrawer: openDrawer))),
      ),
    );
  }

  Widget buildDrawer() => SafeArea(
          child: DrawerWidget(
        closeDrawer: closeDrawer,
      ));
}

class HomeScreenView extends StatelessWidget {
  final VoidCallback openDrawer;

  const HomeScreenView({super.key, required this.openDrawer});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AllProductsBloc>()..fetchProductsPaginated(),
        ),
        BlocProvider(
          create: (_) => getIt<AllBundlesBloc>()..fetchBundlesPaginated(),
        ),
        BlocProvider(
          create: (_) => getIt<CategoriesBloc>()..fetchCategoriesPaginated(),
        )
      ],
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: IconButton(
            onPressed: openDrawer,
            icon: const Icon(
              Icons.grid_view_outlined,
              size: 48,
            ),
          ),
          title: const Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Deliver to',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Direccion Ejemplo: Guarenas, Miranda',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
            ],
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(top: 24, left: 8, right: 8),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: 'Get your',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w100,
                              color: theme.brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            children: [
                              TextSpan(
                                  text: ' groceries',
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.bold)),
                              const TextSpan(
                                text: ' delivered quikly',
                              ),
                            ]),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const CaregoriesCarrusel(),
                      const SizedBox(
                        height: 24,
                      ),
                      const CardBundleCarrusel(),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Popular',
                            style: TextStyle(
                                color: theme.brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 32),
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: Text(
                                'view all',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w700),
                              )),
                        ],
                      )
                    ],
                  ),
                ]),
              ),
            ),
            BlocBuilder<AllProductsBloc, AllProductsState>(
              builder: (context, state) {
                if (state.status == ProductsStatus.loading &&
                    state.products.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state.status == ProductsStatus.error) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: Text('Algo inesperado paso',
                          style: TextStyle(color: Colors.red)),
                    ),
                  );
                }
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        Product current = state.products[index];
                        return CustomItemProduct(
                            current: current, theme: theme);
                      },
                      childCount: state.products.length,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
