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

    return SizedBox(
      height: 88,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(onTap: ()=>context.push('/categories') ,child: Text('view all', textAlign: TextAlign.end, style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.w700),)),
          Expanded(
            child: BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state.status == CategoriesStatus.loading && state.categories.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.status == CategoriesStatus.error) {
                  return const Center(
                    child: Text('Algo inesperado paso', style: TextStyle(color: Colors.red)),
                  );
                }
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => const SizedBox(width: 16),
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
                                  child: Image.network(currentCategory.icon),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                currentCategory.name,
                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800),
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
