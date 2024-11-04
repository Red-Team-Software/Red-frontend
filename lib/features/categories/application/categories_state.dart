part of 'categories_bloc.dart';

enum CategoriesStatus { loading, error, loaded, allLoaded }

class CategoriesState extends Equatable {
  final List<Category> categories;
  final CategoriesStatus status;
  final int page;
  final int perPage;

  const CategoriesState({
    this.categories = const [],
    this.status = CategoriesStatus.loaded,
    this.page = 1,
    this.perPage = 10,
  });

  CategoriesState copyWith({
    List<Category>? categories,
    CategoriesStatus? status,
    int? page,
    int? perPage,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      status: status ?? this.status,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
    );
  }

  @override
  List<Object> get props => [categories, status, page, perPage];
}
