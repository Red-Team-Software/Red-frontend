import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/bundles/domain/repositories/bundle_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'all_bundles_event.dart';
part 'all_bundles_state.dart';

class AllBundlesBloc extends Bloc<AllBundlesEvent, AllBundlesState> {

  final IBundleRepository bundleRepository;

  AllBundlesBloc({required this.bundleRepository}) : super(const AllBundlesState()) {
    on<BundlesFetched>(_onBundlesFetched);
    on<BundlesLoading>(_onBundlesLoading);
    on<BundlesIsEmpty>(_onBundlesIsEmpty);
    on<BundlesError>(_onBundlesError);
  }


  void _onBundlesFetched(
      BundlesFetched event, Emitter<AllBundlesState> emit) {
    emit(state.copyWith(
      bundles: event.bundles,
      status: BundlesStatus.loaded,
    ));
  }

  void _onBundlesIsEmpty(
      BundlesIsEmpty event, Emitter<AllBundlesState> emit) {
    emit(state.copyWith(
      status: BundlesStatus.allLoaded,
    ));
  }

  void _onBundlesLoading(
      BundlesLoading event, Emitter<AllBundlesState> emit) {
    emit(state.copyWith(
      status: BundlesStatus.loading,
    ));
  }

  void _onBundlesError(BundlesError event, Emitter<AllBundlesState> emit) {
    emit(state.copyWith(
      status: BundlesStatus.error,
    ));
  }

  Future<void> fetchBundlesPaginated() async {
    if (state.status == BundlesStatus.allLoaded ||
        state.status == BundlesStatus.loading ||
        state.status == BundlesStatus.error) return;
    add(const BundlesLoading());

    final res = await bundleRepository.getBundlesPaginated(
      page: state.page,
      perPage: state.perPage,
    );

    if (res.isSuccessful()) {
      final bundles = res.getValue();
      if (bundles.isEmpty) {
        add(const BundlesIsEmpty());
        return;
      }
      add(BundlesFetched(bundles));
      return;
    } else {
      add(const BundlesError());
    }
  }
}
