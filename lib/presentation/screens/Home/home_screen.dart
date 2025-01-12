import 'package:GoDeli/features/categories/application/all-categories/categories_bloc.dart';
import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/user/application/bloc/user_bloc.dart';
import 'package:GoDeli/features/user/domain/user_direction.dart';
import 'package:flutter/material.dart';
import 'package:GoDeli/features/products/application/products/all_products_bloc.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const String name = 'home_screen';

  const HomeScreen({super.key});

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
        xOffset = context.size!.width * 0.55;
        yOffset = context.size!.height * 0.25;
        scaleFactor = 0.75;
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

    return BlocProvider(
      create: (_) => getIt<UserBloc>(),
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
          title: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              
              if (state is UserSuccess) {
                UserDirection favoriteDirection = state.user.directions.first;
                for (var direction in state.user.directions) {
                  if (direction.isFavorite ==true ) {
                    favoriteDirection = direction;
                    break;
                  }
                }
                return Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Deliver to',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(favoriteDirection.address,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400)),
                  ],
                );
              }
              return const Text('Loading...');
            },
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
                      const _CarruselItems(),
                    ],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CarruselItems extends StatelessWidget {
  const _CarruselItems();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final categ = context.read<CategoriesBloc>().state.categories;


    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
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
              onTap: ()=>context.push('/catalog'),
              child: Text(
                'view all',
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700),
              )),
        ],
      ),
      BlocBuilder<AllProductsBloc, AllProductsState>(
        builder: (context, state) {
          if (state.status == ProductsStatus.loading &&
              state.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status != ProductsStatus.loading &&
              state.products.isEmpty) {
            return const Center(child: Text('No hay productos'));
          }
          if (state.status == ProductsStatus.error) {
            return const Center(
              child: Text('Algo inesperado paso',
                  style: TextStyle(color: Colors.red)),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: SizedBox(
              height: 200, // Ajusta la altura según tus necesidades
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 8,
                    childAspectRatio:
                        0.28 // Ajusta el aspecto para que ocupe todo el ancho
                    ),
                itemCount: state.products.length,
                itemBuilder: (BuildContext context, int index) {
                  Product currentProduct = state.products[index];
                  return SizedBox(
                    width: MediaQuery.of(context)
                        .size
                        .width, // Ocupa todo el ancho de la pantalla
                    child: CustomItemProduct(
                        current: currentProduct, theme: theme),
                  );
                },
              ),
            ),
          );
        },
      ),
    ]);
  }
}
