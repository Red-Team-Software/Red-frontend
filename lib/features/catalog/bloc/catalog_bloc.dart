import 'package:GoDeli/features/categories/domain/category.dart';
import 'package:GoDeli/features/products/domain/repositories/products_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final IProductsRepository productsRepository;
  final IBundlesRepository bundleRepository;

  CatalogBloc({ required this.bundleRepository, required this.productsRepository }) : super(const CatalogState()) {
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
    var cate = state.categorySelected;
    cate.add(event.category);
    emit(state.copyWith(
      categorySelected: cate,
    ));
    fetchItems();
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

  void fetchItems() async {
    print('fetchItems');
    add(const CatalogLoading());
    try {
      final resPro = await productsRepository.getProducts(category);
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

class IBundlesRepository {
}
