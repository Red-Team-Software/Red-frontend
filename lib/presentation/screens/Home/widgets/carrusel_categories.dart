import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/categories/application/categories_bloc.dart';

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
          GestureDetector(onTap: (){ },child: Text('Ver mas', textAlign: TextAlign.end, style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.w700),)),
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
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    Category currentCategory = state.categories[index];
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 80,
                        margin: EdgeInsets.only(
                          left: 16,
                          right: index == state.categories.length - 1 ? 15 : 0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Card(
                          elevation: 5,
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
