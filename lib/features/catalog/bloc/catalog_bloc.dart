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
    on<PopularSet>(_onPopularSet);
    on<DiscountSet>(_onDiscountSet);
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
    var cate = List<String>.from(state.categorySelected);
    
    cate.any((element) => element == event.category) ? cate.remove(event.category) : cate.add(event.category);
    emit(state.copyWith(
      categorySelected: cate,
    ));
    fetchItems();
  }

  void _onPopularSet(PopularSet event, Emitter<CatalogState> emit) {
    final popular = event.popular ?? !state.popular;
    emit(state.copyWith(
      popular: popular,
    ));
    fetchItems();
  }

  void _onDiscountSet(DiscountSet event, Emitter<CatalogState> emit) {
    emit(state.copyWith(
      discount: event.discount,
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
    print('Categoria tal: ${state.categorySelected}');
    add(const CatalogLoading());
    try {
      final resPro = await productsRepository.getProducts(
        category: state.categorySelected,
        discount: state.discount==0.0 ? null : state.discount,
        popular: state.popular ? 'popular' : null,
        page: state.page,
        perPage: state.perPage,
      );

      final resBun = await bundleRepository.getBundlesPaginated(
        category: state.categorySelected,
        discount: state.discount==0.0 ? null : state.discount,
        popular: state.popular ? 'popular' : null,
        page: state.page,
        perPage: state.perPage,
      );

      if (resPro.isSuccessful() && resBun.isSuccessful()) {
        final products = resPro.getValue();
        final bundles = resBun.getValue();

        add(ItemsFetched(products, bundles));
      } else {
        add(CatalogError(resPro.getError().toString()));
      }
    } catch (e) {
      add(CatalogError(e.toString()));
    }
  }
}
