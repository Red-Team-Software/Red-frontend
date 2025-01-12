import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/categories/application/all-categories/categories_bloc.dart';

class CaregoriesCarrusel extends StatelessWidget {
  const CaregoriesCarrusel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = theme.textTheme;

    return SizedBox(
      height: 88,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
              onTap: () => context.push('/categories'),
              child: Text(
                'view all',
                textAlign: TextAlign.end,
                style: textStyles.displaySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold),
              )),
          Expanded(
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state.status == CategoriesStatus.loading &&
                    state.categories.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.categories.isEmpty && (state.status == CategoriesStatus.allLoaded || state.status == CategoriesStatus.loaded)) {
                  return const Center(child: Text('Algo raro paso, No hay categorias!', style: TextStyle(color: Colors.red)));
                }
                if (state.status == CategoriesStatus.error) {
                  return Center(
                    child: Text('Algo inesperado paso',
                        style: textStyles.bodyLarge?.copyWith(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.bold)),
                  );
                }
                if (state.status != CategoriesStatus.loading && state.categories.isEmpty) {
                  return const Center(child: Text('No hay categorias'));
                }
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 16),
                  itemCount: state.categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    Category currentCategory = state.categories[index];
                    return GestureDetector(
                      onTap: () {
                        context.push('/catalog/${currentCategory.id}');
                      },
                      child: SizedBox(
                        width: 80,
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Image.network(currentCategory.icon!),
                                ),
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
