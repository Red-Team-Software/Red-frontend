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

  CatalogBloc({
    required this.bundleRepository,
    required this.productsRepository,
  }) : super(const CatalogState()) {
    on<ItemsFetched>(_onItemsFetched);
    on<CategorySet>(_onCategorySet);
    on<CategoryListSet>(_onCategoryListSet);
    on<PopularSet>(_onPopularSet);
    on<DiscountSet>(_onDiscountSet);
    on<PriceSet>(_onPriceSet);
    on<TermSet>(_onTermSet);
    on<PageSet>(_onPageSet);
    on<PerPageSet>(_onPerPageSet);
    on<CatalogLoading>(_onCatalogLoading);
    on<CatalogIsEmpty>(_onCatalogIsEmpty);
    on<CatalogError>(_onCatalogError);
    on<FetchItems>(_fetchItems); // Cambio para manejar paginación y filtros
    add(const FetchItems());
  }

  void _onItemsFetched(ItemsFetched event, Emitter<CatalogState> emit) {
    if (event.isPagination) {
      emit(state.copyWith(
        products: [...state.products, ...event.product],
        bundles: [...state.bundles, ...event.bundle],
        status: CatalogStatus.loaded,
      ));
    } else {
      emit(state.copyWith(
        products: event.product,
        bundles: event.bundle,
        status: CatalogStatus.loaded,
      ));
    }
  }

  void _onCategorySet(CategorySet event, Emitter<CatalogState> emit) {
    var selectedCategories = List<String>.from(state.categorySelected);
    if (event.category == 'all') {
      selectedCategories.clear();
    } else {
      selectedCategories.contains(event.category)
          ? selectedCategories.remove(event.category)
          : selectedCategories.add(event.category);
    }
    emit(state.copyWith(
      categorySelected: selectedCategories,
      products: [],
      bundles: [],
      page: 1, // Reinicia la página al aplicar el filtro
      status: CatalogStatus.loading,
    ));
    add(const FetchItems());
  }

  void _onCategoryListSet(CategoryListSet event, Emitter<CatalogState> emit) {
    emit(state.copyWith(
      categorySelected: event.category,
      products: [],
      bundles: [],
      page: 1, // Reinicia la página al aplicar el filtro
      status: CatalogStatus.loading,
    ));
    add(const FetchItems());
  }

  void _onPopularSet(PopularSet event, Emitter<CatalogState> emit) {
    emit(state.copyWith(
      popular: event.popular ?? !state.popular,
      products: [],
      bundles: [],
      page: 1, // Reinicia la página al aplicar el filtro
      status: CatalogStatus.loading,
    ));
    add(const FetchItems());
  }

  void _onDiscountSet(DiscountSet event, Emitter<CatalogState> emit) {
    emit(state.copyWith(
      discount: event.discount,
      products: [],
      bundles: [],
      page: 1, // Reinicia la página al aplicar el filtro
      status: CatalogStatus.loading,
    ));
    add(const FetchItems());
  }

  void _onPriceSet(PriceSet event, Emitter<CatalogState> emit) {
    emit(state.copyWith(
      price: event.price,
      products: [],
      bundles: [],
      page: 1, // Reinicia la página al aplicar el filtro
      status: CatalogStatus.loading,
    ));
    add(const FetchItems());
  }

  void _onTermSet(TermSet event, Emitter<CatalogState> emit) {
    emit(state.copyWith(
      term: event.term,
      products: [],
      bundles: [],
      page: 1, // Reinicia la página al aplicar el filtro
      status: CatalogStatus.loading,
    ));
    add(const FetchItems());
  }

  void _onPageSet(PageSet event, Emitter<CatalogState> emit) {
    emit(state.copyWith(page: event.page));
    add(const FetchItems());
  }

  void _onPerPageSet(PerPageSet event, Emitter<CatalogState> emit) {
    emit(state.copyWith(perPage: event.perPage));
    add(const FetchItems());
  }

  void _onCatalogLoading(CatalogLoading event, Emitter<CatalogState> emit) {
    emit(state.copyWith(status: CatalogStatus.loading));
  }

  void _onCatalogIsEmpty(CatalogIsEmpty event, Emitter<CatalogState> emit) {
    emit(state.copyWith(
      status: CatalogStatus.loaded,
      products: [],
      bundles: [],
    ));
  }

  void _onCatalogError(CatalogError event, Emitter<CatalogState> emit) {
    emit(state.copyWith(status: CatalogStatus.error));
  }

  void _fetchItems(FetchItems event, Emitter<CatalogState> emit) async {
    if (!event.isPagination) {
      emit(state.copyWith(
        products: [],
        bundles: [],
        page: 1,
        status: CatalogStatus.loading,
      ));
    }
    add(const CatalogLoading());
    try {
      final resPro = await productsRepository.getProducts(
        category:
            state.categorySelected.isEmpty ? null : state.categorySelected,
        discount: state.discount == 0.0 ? null : state.discount,
        popular: state.popular ? 'popular' : null,
        page: state.page,
        perPage: state.perPage,
        price: state.price == 0.0 ? null : state.price,
        term: state.term.isEmpty ? null : state.term,
      );

      final resBun = await bundleRepository.getBundlesPaginated(
        category:
            state.categorySelected.isEmpty ? null : state.categorySelected,
        discount: state.discount == 0.0 ? null : state.discount,
        popular: state.popular ? 'popular' : null,
        page: state.page,
        perPage: state.perPage,
        price: state.price == 0.0 ? null : state.price,
        term: state.term.isEmpty ? null : state.term,
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
