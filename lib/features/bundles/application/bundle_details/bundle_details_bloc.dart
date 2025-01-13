import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/bundles/domain/repositories/bundle_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bundle_details_event.dart';
part 'bundle_details_state.dart';

final initialBundle = Bundle(
    id: '', name: '', description: '', price: 0, imageUrl: [''], currency: '');

class BundleDetailsBloc extends Bloc<BundleDetailsEvent, BundleDetailsState> {
  final IBundleRepository bundleRepository;

  BundleDetailsBloc({required this.bundleRepository})
      : super(BundleDetailsState(bundle: initialBundle)) {
    on<BundleLoaded>(_onBundleLoaded);
    on<LoadingStarted>(_onLoadingStarted);
    on<ErrorOnBundleLoading>(_onErrorOnBundleLoading);
  }

  void _onBundleLoaded(BundleLoaded event, Emitter<BundleDetailsState> emit) {
    emit(state.copyWith(
        status: BundleDetailsStatus.loaded, bundle: event.bundle));
  }

  void _onLoadingStarted(
      LoadingStarted event, Emitter<BundleDetailsState> emit) {
    emit(state.copyWith(status: BundleDetailsStatus.loading));
  }

  void _onErrorOnBundleLoading(
      ErrorOnBundleLoading event, Emitter<BundleDetailsState> emit) {
    emit(state.copyWith(status: BundleDetailsStatus.error));
  }

  Future<void> getBundleById(String id) async {
    if (state.status == BundleDetailsStatus.loading) return;
    add(LoadingStarted());
    final res = await bundleRepository.getBundleById(id);

    if (res.isSuccessful()) {
      final bundle = res.getValue();
      add(BundleLoaded(bundle: bundle));
      return;
    }
    print(res.getError());
    add(ErrorOnBundleLoading());
  }
}
