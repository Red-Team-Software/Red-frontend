import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
    required this.categories,
    required this.selectedCategories,
    required this.onCategorySelected,
  });

  final List<Category> categories;
  final List<String> selectedCategories;
  final Function(String) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return SizedBox(
      height: 80,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategories.contains(category.name);

          return ChoiceChip(
            showCheckmark: false,
            selectedColor: Theme.of(context).primaryColor,
            disabledColor: Colors.grey[200],
            selected: isSelected,
            onSelected: (selected) {
              onCategorySelected(category.name);
            },
            label: TranslationWidget(
              message: category.name,
              toLanguage:
                  context.watch<LanguagesCubit>().state.selected.language,
              builder: (translated) => Text(translated),
            ),
            labelStyle: textStyle.displaySmall?.copyWith(
              color: isSelected ? Colors.white : Theme.of(context).primaryColor,
            ),
            elevation: 5.0,
          );
        },
      ),
    );
  }
}
