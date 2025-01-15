import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/features/categories/application/all-categories/categories_bloc.dart';

class CategoriesCarrusel extends StatelessWidget {
  const CategoriesCarrusel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = theme.textTheme;

    return SizedBox(
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Botón "view all"
          GestureDetector(
            onTap: () => context.push('/categories'),
            child: Text(
              'view all',
              textAlign: TextAlign.end,
              style: textStyles.displaySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          // BlocBuilder para categorías
          SizedBox(
            height: 100,
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state.status == CategoriesStatus.loading &&
                    state.categories.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.categories.isEmpty &&
                    (state.status == CategoriesStatus.allLoaded ||
                        state.status == CategoriesStatus.loaded)) {
                  return Center(
                    child: Text(
                      'Algo raro pasó, no hay categorías!',
                      style: textStyles.bodyLarge?.copyWith(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.bold),
                    ),
                  );
                }

                if (state.status == CategoriesStatus.error) {
                  return Center(
                    child: Text(
                      'Algo inesperado pasó',
                      style: textStyles.bodyLarge?.copyWith(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.bold),
                    ),
                  );
                }

                if (state.status != CategoriesStatus.loading &&
                    state.categories.isEmpty) {
                  return Center(child: Text('No hay categorías', style: textStyles.bodyLarge?.copyWith(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.bold)));
                }

                // Carrusel de categorías
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 16),
                  itemCount: state.categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    final currentCategory = state.categories[index];
                    return GestureDetector(
                      onTap: () {
                        context.push('/catalog/${currentCategory.name}');
                      },
                      child: SizedBox(
                        width: 80,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icono de categoría
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    currentCategory.icon!,
                                    height: 24,
                                    width: 24,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Nombre de la categoría
                                TranslationWidget(
                                  message: currentCategory.name,
                                  toLanguage: 'English',
                                  builder:(translatedMessage) =>  Text(
                                    currentCategory.name,
                                    style: textStyles.bodySmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
