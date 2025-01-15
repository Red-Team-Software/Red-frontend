part of 'bundle_offers_bloc.dart';

sealed class BundleOffersEvent extends Equatable {
  const BundleOffersEvent();

  @override
  List<Object> get props => [];
}

final class FetchBundleOffers extends BundleOffersEvent {}