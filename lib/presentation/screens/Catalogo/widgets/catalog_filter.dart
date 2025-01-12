import 'package:GoDeli/features/catalog/bloc/catalog_bloc.dart';
import 'package:GoDeli/features/search/application/bloc/bloc.dart';
import 'package:flutter/material.dart';

class FilterCatalog extends StatelessWidget {
  const FilterCatalog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.00),
      height: 80,
      child: Row(children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            foregroundColor: context
                .watch<CatalogBloc>()
                .state
                .popular
                ? Colors.white
                : Theme.of(context).primaryColor,
            backgroundColor: context
                    .watch<CatalogBloc>()
                    .state
                    .popular
                ? Theme.of(context).primaryColor
                : Colors.white,
          ),
          iconAlignment: IconAlignment.end,
          onPressed: () =>
              context.read<CatalogBloc>()..add(const PopularSet()),
          label: const Text('Popular'),
          icon: const Icon(Icons.star),
        ),
        const SizedBox(width: 12),
        Text('Discount: ${context.watch<CatalogBloc>().state.discount}%'),
        Expanded(
          child: Slider(
            value: context.read<CatalogBloc>().state.discount,
            onChanged: (value) {
              // Update the slider value in the state
              context.read<CatalogBloc>().add(DiscountSet(value));
            },
            onChangeEnd: (value) {
              // Make the request and change the state when the slider is released
              context.read<CatalogBloc>().add(DiscountSet(value));
            },
          ),
        ),
      ]),
    );
  }
}