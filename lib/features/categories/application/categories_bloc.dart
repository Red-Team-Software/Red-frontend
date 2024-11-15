import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:bloc/bloc.dart';
import 'package:GoDeli/features/categories/domain/repositories/categories_repository.dart';
import 'package:equatable/equatable.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {

  final ICategoriesRepository categoryRepository;

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
      status: CategoriesStatus.allLoaded,
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

  Future<void> fetchCategoriesPaginated() async {
    if (state.status == CategoriesStatus.allLoaded || state.status == CategoriesStatus.loading || state.status==CategoriesStatus.error) return;
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

