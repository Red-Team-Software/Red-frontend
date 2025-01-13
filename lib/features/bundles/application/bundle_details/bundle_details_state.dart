part of 'bundle_details_bloc.dart';


enum BundleDetailsStatus { initial, loading, loaded, error }

class BundleDetailsState extends Equatable {
  
  final Bundle bundle;
  final BundleDetailsStatus status;

  const BundleDetailsState({
    required this.bundle,
    this.status = BundleDetailsStatus.initial,
  });

  BundleDetailsState copyWith({
    Bundle? bundle,
    BundleDetailsStatus? status,
  }) {
    return BundleDetailsState(
      bundle: bundle ?? this.bundle,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [ bundle, status ];
}

