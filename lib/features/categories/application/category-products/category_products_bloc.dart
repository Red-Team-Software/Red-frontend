import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_products_event.dart';
part 'category_products_state.dart';

class CategoryProductsBloc extends Bloc<CategoryProductsEvent, CategoryProductsState> {
  CategoryProductsBloc() : super(const CategoryProductsState()) {
    on<FetchProducts>(_onFetchProducts);
    on<CategoryChanged>(_onCategoryChanged);
    on<ProductsFetched>(_onProductsFetched);
    on<ProductsLoading>(_onProductsLoading);
    on<ProductsIsEmpty>(_onProductsIsEmpty);
    on<ProductsError>(_onProductsError);
  }

  void _onFetchProducts(FetchProducts event, Emitter<CategoryProductsState> emit) {
    UnimplementedError();
  }

  void _onCategoryChanged(CategoryChanged event, Emitter<CategoryProductsState> emit) {
    emit(state.copyWith(selectedCategory: event.categoryId));
    add(FetchProducts(event.categoryId));
  }

  void _onProductsFetched(ProductsFetched event, Emitter<CategoryProductsState> emit) {
    emit(state.copyWith(products: event.products));
  }

  void _onProductsLoading(ProductsLoading event, Emitter<CategoryProductsState> emit) {
    emit(state.copyWith(status: CategoryProductsStatus.loading));
  }

  void _onProductsIsEmpty(ProductsIsEmpty event, Emitter<CategoryProductsState> emit) {
    emit(state.copyWith(status: CategoryProductsStatus.loaded));
  }

  void _onProductsError(ProductsError event, Emitter<CategoryProductsState> emit) {
    emit(state.copyWith(status: CategoryProductsStatus.error));
  }
}
