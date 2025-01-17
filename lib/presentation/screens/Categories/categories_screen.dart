import 'package:GoDeli/config/injector/injector.dart';
import 'package:GoDeli/features/categories/application/all-categories/categories_bloc.dart';
import 'package:GoDeli/presentation/core/translation/translation_widget.dart';
import 'package:GoDeli/presentation/screens/languages/cubit/languages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CategoriesScreen extends StatelessWidget {
  static const String name = 'categories_screen';

  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CategoriesBloc>()..fetchCategoriesPaginated(),
      child: const _CategoriesView(),
    );
  }
}

class _CategoriesView extends StatelessWidget {
  const _CategoriesView();

  @override
  Widget build(BuildContext context) {
    final language =  context.watch<LanguagesCubit>().state.selected.language;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: 
        TranslationWidget(
            message:'All Categories',
            toLanguage: language,
            builder: (translated) => Text(
              translated
          ), 
        ),
        actions: const [
          Icon(Icons.search, size: 32,),
          SizedBox(width: 8,)
        ],
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
      
          if (state.status == CategoriesStatus.loading && state.categories.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.status == CategoriesStatus.error) {
            return Center(
              child: TranslationWidget(
                message:'Algo inesperado paso',
                toLanguage: language,
                builder: (translated) => Text(
                    translated,
                    style: const TextStyle(color: Colors.red)
                ), 
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 16.00, left:16.00, right: 16.00),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing:16.0,
                mainAxisSpacing: 24.0,
                childAspectRatio: 0.8
              ),
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return InkWell(
                  onTap: () => context.push('/catalog/${category.name}'),
                  child: Card(
                    elevation: 6.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Image.network(
                              category.icon!,
                              fit: BoxFit.contain,
                              width: 70.00,
                            ),
                          ),
                          TranslationWidget(
                            message: category.name,
                            toLanguage: context.read<LanguagesCubit>().state.selected.language,
                            builder: (translated) => Text(
                              translated,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14.0, color: Colors.black54, fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(height: 8.00,)
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
