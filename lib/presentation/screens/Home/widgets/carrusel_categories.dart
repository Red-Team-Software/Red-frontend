import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/categories/application/all-categories/categories_bloc.dart';

class CategoriesCarrusel extends StatelessWidget {
  const CategoriesCarrusel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = theme.textTheme;

    return SizedBox(
      height: 88,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Botón "view all"
          GestureDetector(
            onTap: () => context.push('/categories'),
            child: Text(
              'view all',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // BlocBuilder para categorías
          Expanded(
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state.status == CategoriesStatus.loading &&
                    state.categories.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state.categories.isEmpty &&
                    (state.status == CategoriesStatus.allLoaded ||
                        state.status == CategoriesStatus.loaded)) {
                  return const Center(
                    child: Text(
                      'Algo raro pasó, no hay categorías!',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (state.status == CategoriesStatus.error) {
                  return const Center(
                    child: Text(
                      'Algo inesperado pasó',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (state.status != CategoriesStatus.loading &&
                    state.categories.isEmpty) {
                  return const Center(child: Text('No hay categorías'));
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
                                Text(
                                  currentCategory.name,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  textAlign: TextAlign.center,
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
