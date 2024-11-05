import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:flutter/material.dart';
import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/presentation/widgets/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/features/categories/application/categories_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return _HomeScreenView(colors: colors);
  }
}

class _HomeScreenView extends StatelessWidget {
  const _HomeScreenView({
    required this.colors,
  });

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.grid_view_outlined,
          size: 48,
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flex(direction: Axis.horizontal, children: [
                      const Text('Get your ',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w100,
                          )),
                      Text(
                        'groceries',
                        style: TextStyle(
                            fontSize: 40,
                            color: colors.primary,
                            fontWeight: FontWeight.bold),
                      )
                    ]),
                    const Text(
                      'delivered quikly',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.w100),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    BlocProvider(
                      create: (_) => getIt<CategoriesBloc>()..loadNextPage(),
                      child: const _CaregoriesCarrusel(),
                    )
                  ]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

class _CaregoriesCarrusel extends StatelessWidget {
  const _CaregoriesCarrusel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 72,
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
        if (state.status == CategoriesStatus.loading &&
            state.categories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == CategoriesStatus.error) {
          return const Center(
            child: Text('Algo inesperado paso',
                style: TextStyle(color: Colors.red)),
          );
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state.categories.length,
          itemBuilder: (BuildContext context, int index) {
            Category currentCategory = state.categories[index];
            return GestureDetector(
              onTap: () {},
              child: Container(
                width: 72,
                margin: EdgeInsets.only(
                  left: 16,
                  right: index == state.categories.length - 1 ? 15 : 0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Card(
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Image.network(currentCategory.icon),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentCategory.name,
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
