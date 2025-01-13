import 'package:GoDeli/features/bundles/application/bundles/all_bundles_bloc.dart';
import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/categories/application/all-categories/categories_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class CardBundleCarrusel extends StatelessWidget {
  const CardBundleCarrusel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textStyles = theme.textTheme;
    final categ = context.read<CategoriesBloc>().state.categories;


    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: SizedBox(
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('Bundle Offers', style: textStyles.displayLarge),
                GestureDetector(
                    onTap: () => context.push('/catalog'),
                    child: Text(
                      'view all',
                      textAlign: TextAlign.end,
                      style: textStyles.displaySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            Expanded(child: BlocBuilder<AllBundlesBloc, AllBundlesState>(
                builder: (context, state) {
              final textStyles = theme.textTheme;
              if (state.status == BundlesStatus.loading &&
                  state.bundles.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.bundles.isEmpty &&
                  (state.status == BundlesStatus.allLoaded ||
                      state.status == BundlesStatus.loaded)) {
                return const Center(
                    child: Text('Algo raro paso, No hay Bundles!',
                        style: TextStyle(color: Colors.red)));
              }
              if (state.status == BundlesStatus.error) {
                return Center(
                  child: Text('Algo inesperado paso',
                      style: textStyles.bodyLarge?.copyWith(
                          color: theme.colorScheme.error,
                          fontWeight: FontWeight.bold)),
                );
              }
              if (state.status != BundlesStatus.loading &&
                  state.bundles.isEmpty) {
                return const Center(child: Text('No hay items para mostrar'));
              }
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: state.bundles.length,
                itemBuilder: (BuildContext context, int index) {
                  Bundle current = state.bundles[index];
                  return GestureDetector(
                    onTap: () {},
                    child: CardItem(current: current),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 24); // Espacio entre los elementos
                },
              );
            }))
          ],
        ),
      ),
    );
  }
}
