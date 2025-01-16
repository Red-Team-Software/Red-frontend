part of 'bundle_offers_bloc.dart';

class BundleOffersState  {}

final class BundleOffersLoading extends BundleOffersState {}

final class BundleOffersLoaded extends BundleOffersState {
  final List<Bundle> bundles;

  BundleOffersLoaded(this.bundles);
}

final class BundleOffersError extends BundleOffersState {
  final String message;

  BundleOffersError(this.message);
}