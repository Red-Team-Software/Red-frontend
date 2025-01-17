import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/search/application/bloc/bloc.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/Catalogo/widgets/categories_list.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:flutter/material.dart';

class FilterModal extends StatefulWidget {
  final List<Category> categories;
  final List<String> selectedCategories;
  final double discount;
  final bool popular;
  final double price;
  final String term;

  const FilterModal({
    super.key,
    required this.categories,
    this.selectedCategories = const [],
    this.discount = 0.0,
    this.popular = false,
    this.price = 0.0,
    this.term = '',
  });

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  late List<String> _selectedCategories;
  late double _discount;
  late bool _popular;
  late double _price;
  late String _term;

  @override
  void initState() {
    super.initState();
    _selectedCategories = List.from(widget.selectedCategories);
    _discount = widget.discount;
    _popular = widget.popular;
    _price = widget.price;
    _term = widget.term;
  }

  @override
Widget build(BuildContext context) {
  final textStyle = Theme.of(context).textTheme;
  final colors = Theme.of(context).colorScheme;
  final language =  context.watch<LanguagesCubit>().state.selected.language;

  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      constraints: const BoxConstraints(maxHeight: 700), // Ajustar el tamaño máximo
      child: SingleChildScrollView( // Permite desplazar el contenido
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TranslationWidget(
              message: 'Filters',
              toLanguage: context.watch<LanguagesCubit>().state.selected.language,
              builder: (translated) => Text(translated, style: textStyle.displayLarge),
            ),
            const Divider(color: Colors.black),
            const SizedBox(height: 16),

            TranslationWidget(
              message: 'Categories',
              toLanguage: context.watch<LanguagesCubit>().state.selected.language,
              builder: (translated) => Text(translated, style: textStyle.displayMedium),
            ),
            CategoriesList(
              categories: widget.categories,
              selectedCategories: _selectedCategories,
              onCategorySelected: (category) {
                setState(() {
                  if (_selectedCategories.contains(category)) {
                    _selectedCategories.remove(category);
                  } else {
                    _selectedCategories.add(category);
                  }
                });
              },
            ),
            const Divider(color: Colors.black),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botón Popular
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    foregroundColor: _popular ? Colors.white : colors.primary,
                    backgroundColor: _popular ? colors.primary : Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  ),
                  onPressed: () {
                    setState(() {
                      _popular = !_popular;
                    });
                  },
                  label: TranslationWidget(
                    message: 'Popular',
                    toLanguage: context.watch<LanguagesCubit>().state.selected.language,
                    builder: (translated) => Text(
                      translated,
                      style: textStyle.displaySmall!.copyWith(
                        color: _popular ? Colors.white : Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  icon: const Icon(Icons.star),
                ),
                const SizedBox(width: 12),

                // Switch Discounts
                Row(
                  children: [
                    TranslationWidget(
                      message:'Discounts',
                      toLanguage: language,
                      builder: (translated) => Text(
                        translated,
                        style: textStyle.displaySmall
                      ), 
                    ),
                    const SizedBox(width: 8),
                    Switch(
                      value: _discount == 0.5,
                      onChanged: (value) {
                        setState(() {
                          _discount = value ? 0.5 : 0.0;
                        });
                      },
                      activeColor: colors.primary,
                      inactiveThumbColor: Colors.grey,
                      inactiveTrackColor: Colors.grey.shade300,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: Colors.black),
            const SizedBox(height: 16),

            TranslationWidget(
              message: 'Max Price: ${_price.toStringAsFixed(2)}',
              toLanguage: context.watch<LanguagesCubit>().state.selected.language,
              builder: (translated) => Text(translated, style: textStyle.displayMedium),
            ),
            Slider(
              value: _price,
              min: 0,
              max: 50,
              divisions: 20,
              label: _price.toString(),
              onChanged: (value) {
                setState(() {
                  _price = value;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: colors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              ),
              onPressed: () {
                Navigator.of(context).pop({
                  'categories': _selectedCategories,
                  'discount': _discount,
                  'popular': _popular,
                  'price': _price,
                  'term': _term,
                });
              },
              child: TranslationWidget(
                message: 'Apply Filters',
                toLanguage: context.watch<LanguagesCubit>().state.selected.language,
                builder: (translated) => Text(translated,
                    style: textStyle.displayMedium?.copyWith(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}
