import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/bundles/domain/repositories/bundle_repository.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/features/products/domain/repositories/products_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final IProductsRepository productsRepository;
  final IBundleRepository bundleRepository;

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
    cate.any((element) => element == event.category) ? cate.remove(event.category) : cate.add(event.category);
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
      final resPro = await productsRepository.getProducts(
        category: state.categorySelected,
        page: state.page,
        perPage: state.perPage,
      );
      print(resPro);
      if (resPro.isSuccessful()) {
        final products = resPro.getValue();


        add(ItemsFetched(products, []));
      } else {
        add(CatalogError(resPro.getError().toString()));
      }
    } catch (e) {
      add(CatalogError(e.toString()));
    }
  }
}

class IBundlesRepository {
}
