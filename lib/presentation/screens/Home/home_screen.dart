import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/user/application/bloc/user_bloc.dart';
import 'package:GoDeli/features/user/domain/user_direction.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/Home/widgets/banner_carrousel.dart';
import 'package:GoDeli/presentation/screens/Home/widgets/carrusel_categories.dart';
import 'package:GoDeli/presentation/screens/Home/widgets/drawer_widget.dart';
import 'package:GoDeli/presentation/screens/Home/widgets/popular_products_home.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:GoDeli/presentation/widgets/dot_list/custom_dots_list.dart';
import 'package:flutter/material.dart';
import 'package:GoDeli/features/products/application/products/all_products_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

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
    final language =  context.watch<LanguagesCubit>().state.selected.language;

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
                  if (direction.isFavorite == true) {
                    favoriteDirection = direction;
                    break;
                  }
                }
                return Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TranslationWidget(
                      message:'Deliver to',
                      toLanguage: language,
                      builder: (translated) => Text(
                        translated,
                        style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))
                    ),
                    TranslationWidget(
                      message:favoriteDirection.direction,
                      toLanguage: language,
                      builder: (translated) => Text(
                        translated,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400))
                    ),
                  ],
                );
              }
              return TranslationWidget(
                      message:"Loading...",
                      toLanguage: language,
                      builder: (translated) => Text(
                        translated,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400))
                    );
            },
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(top: 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: TranslationWidget(
                          message: 'Get Your',
                          toLanguage: language,
                          builder: (tGet) => TranslationWidget(
                            message: ' groceries',
                            toLanguage: language,
                            builder:(tGro) => TranslationWidget(
                              message: ' delivered quickly',
                              toLanguage: language,
                              builder: (tDel) => RichText(
                                text: TextSpan(
                                    text: tGet,
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w100,
                                      color: theme.brightness == Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    children: [
                                      TextSpan(
                                          text: tGro,
                                          style: TextStyle(
                                              fontSize: 40,
                                              color: theme.colorScheme.primary,
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                        text: tDel,
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      // HomeBannerCarrousel(),
                      const SizedBox(
                        height: 24,
                      ),
                      const PopularProductsHome(),
                      const SizedBox(
                        height: 24,
                      ),
                      const CategoriesCarrusel(),
                      const SizedBox(
                        height: 24,
                      ),
                      const CardBundleCarrusel(),
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





