import 'package:GoDeli/features/bundles/application/bundles/all_bundles_bloc.dart';
import 'package:GoDeli/features/bundles/domain/bundle.dart';
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
    return SizedBox(
      height: 304,
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
            if (state.status == BundlesStatus.error) {
              return Center(
                child: Text('Algo inesperado paso',
                    style: textStyles.bodyLarge?.copyWith(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.bold)),
              );
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
    );
  }
}
