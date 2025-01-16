import 'package:GoDeli/features/catalog/bloc/catalog_bloc.dart';
import 'package:GoDeli/features/search/application/bloc/bloc.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:flutter/material.dart';

class DiscountPopularPriceFilterCatalog extends StatelessWidget {
  const DiscountPopularPriceFilterCatalog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final language = context.watch<LanguagesCubit>().state.selected.language;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.00),
      height: 80,
      child: Row(
        children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            foregroundColor: context
                .watch<CatalogBloc>()
                .state
                .popular
                ? Colors.white
                : colors.primary,
            backgroundColor: context
                    .watch<CatalogBloc>()
                    .state
                    .popular
                ? colors.primary
                : Colors.white,
          ),
          iconAlignment: IconAlignment.end,
          onPressed: () =>
              context.read<CatalogBloc>()..add(const PopularSet()),
          label: TranslationWidget(
                  message:'Popular',
                  toLanguage: language,
                  builder: (translated) => Text(
                      translated,
                      style:textStyles.displaySmall!.copyWith(
              color: context
                  .watch<CatalogBloc>()
                  .state
                  .popular
                  ? Colors.white
                  : Theme.of(context).primaryColor,
            ),
                    ), 
                  ),
          icon: const Icon(Icons.star),
        ),
        const SizedBox(width: 12),
        Text('Max Price: ${context.watch<CatalogBloc>().state.price}',
            style: textStyles.displaySmall),
        Expanded(
          child: Slider(
            divisions: 100,
            max: 100,
            value: context.read<CatalogBloc>().state.discount,
            onChanged: (value) {
              // Update the slider value in the state
              context.read<CatalogBloc>().add(PriceSet(value));
            },
            onChangeEnd: (value) {
              // Make the request and change the state when the slider is released
              context.read<CatalogBloc>().add(PriceSet(value));
            },
          ),
        ),
        const SizedBox(width: 12),
        
      ]),
    );
  }
}