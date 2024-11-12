part of 'all_bundles_bloc.dart';

enum BundlesStatus {loading, loaded, error, allLoaded}

class AllBundlesState extends Equatable {

  final List<Bundle> bundles;
  final BundlesStatus status;
  final int page;
  final int perPage;

  const AllBundlesState({
    this.bundles = const [], 
    this.status = BundlesStatus.loaded, 
    this.page = 1, 
    this.perPage = 10 
  });

  AllBundlesState copyWith({
    List<Bundle>? bundles,
    BundlesStatus? status,
    int? page,
    int? perPage,
  }) {
    return AllBundlesState(
      bundles: bundles ?? this.bundles,
      status: status ?? this.status,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
    );
  }
  
  @override
  List<Object> get props => [bundles, status, page, perPage];
}

