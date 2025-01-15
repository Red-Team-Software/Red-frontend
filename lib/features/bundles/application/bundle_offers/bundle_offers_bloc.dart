import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/bundles/domain/repositories/bundle_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bundle_offers_event.dart';
part 'bundle_offers_state.dart';

class BundleOffersBloc extends Bloc<BundleOffersEvent, BundleOffersState> {
  final IBundleRepository bundleRepository;
  
  BundleOffersBloc({
    required this.bundleRepository,
  }) : super((BundleOffersState())) {
    on<FetchBundleOffers>(_onFetchBundleOffers);
    add(FetchBundleOffers());
  }

  void _onFetchBundleOffers(FetchBundleOffers event, Emitter<BundleOffersState> emit) async {
    emit(BundleOffersLoading());
    // TODO: poner el valor de discount
    final res = await bundleRepository.getBundlesPaginated(page: 1, perPage: 5,/* discount: 0.5 */);
    if (!res.isSuccessful()) {
      emit(BundleOffersError('Failed to get bundle offers'));
      return;
    }
    emit(BundleOffersLoaded(res.getValue()));
  }
}
