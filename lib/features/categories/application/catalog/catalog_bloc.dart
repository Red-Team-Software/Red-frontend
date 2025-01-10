import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/categories/domain/repositories/categories_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final ICategoriesRepository itemsRepository;

  CatalogBloc({required this.itemsRepository}) : super(const CatalogState()) {
    on<ItemsFetched>(_onItemsFetched);
    on<CategorySet>(_onCategorySet);
    on<CatalogLoading>(_onCatalogLoading);
    on<CatalogIsEmpty>(_onCatalogIsEmpty);
    on<CatalogError>(_onCatalogError);
  }

  void _onItemsFetched(ItemsFetched event, Emitter<CatalogState> emit) {
    emit(state.copyWith(
      products: event.product,
      bundles: event.bundle,
      status: CatalogStatus.loaded,
    ));
  }

  void _onCategorySet(CategorySet event, Emitter<CatalogState> emit) {
    emit(state.copyWith(
      categorySelected: event.category,
    ));
    fetchItems(event.category);
  }

  void _onCatalogLoading(CatalogLoading event, Emitter<CatalogState> emit) {
    emit(state.copyWith(
      status: CatalogStatus.loading,
    ));
  }

  void _onCatalogIsEmpty(CatalogIsEmpty event, Emitter<CatalogState> emit) {
    emit(state.copyWith(
      status: CatalogStatus.loaded,
      products: [],
      bundles: [],
    ));
  }

  void _onCatalogError(CatalogError event, Emitter<CatalogState> emit) {
    emit(state.copyWith(
      status: CatalogStatus.error,
    ));
  }

  void fetchItems(String categoryId) async {
    print('fetchItems');
    add(const CatalogLoading());
    try {
      final res = await itemsRepository.getCategoryItems(categoryId);
      if (res.isSuccessful()) {
        final categoryDetails = res.getValue();

        if (categoryDetails.products.isEmpty &&
            categoryDetails.bundles.isEmpty) {
          add(const CatalogIsEmpty());
          return;
        }

        final products = categoryDetails.products;
        final bundles = categoryDetails.bundles;
        add(ItemsFetched(products, bundles));
      } else {
        add(CatalogError(res.getError().toString()));
      }
    } catch (e) {
      add(CatalogError(e.toString()));
    }
  }
}
