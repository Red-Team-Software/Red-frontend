import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shopping_cart/features/categories/domain/repositories/categories_repository.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {

  final CategoriesRepository categoryRepository;

  CategoriesBloc({required this.categoryRepository})
      : super(const CategoriesState()) {
    on<CategoriesFetched>(_onCategoriesFetched);
    on<CategoriesLoading>(_onCategoriesLoading);
    on<CategoriesIsEmpty>(_onCategoryIsEmpty);
    on<CategoriesError>(_onCategoryError);
  }

  void _onCategoriesFetched(
      CategoriesFetched event, Emitter<CategoriesState> emit) {
    emit(state.copyWith(
      categories: event.categories,
      status: CategoriesStatus.loaded,
    ));
  }

  void _onCategoryIsEmpty(
      CategoriesIsEmpty event, Emitter<CategoriesState> emit) {
    emit(state.copyWith(
      status: CategoriesStatus.categoriesLoaded,
    ));
  }

  void _onCategoriesLoading(
      CategoriesLoading event, Emitter<CategoriesState> emit) {
    emit(state.copyWith(
      status: CategoriesStatus.loading,
    ));
  }

  void _onCategoryError(
      CategoriesError event, Emitter<CategoriesState> emit) {
    emit(state.copyWith(
      status: CategoriesStatus.error,
    ));
  }

  Future<void> loadNextPage() async {
    if (state.isLastPage || state.isLoading || state.isError) return;
    add(const CategoriesLoading());

    final res = await categoryRepository.getCategories();
    if (res.isSuccessful()) {
      final categories = res.getValue();
      if (categories.isEmpty) {
        add(const CategoriesIsEmpty());
        return;
      }
      add(CategoriesFetched(categories));
      return;
    }
    add(const CategoriesError());
  }
}

