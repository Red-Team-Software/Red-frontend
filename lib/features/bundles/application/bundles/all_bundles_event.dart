part of 'all_bundles_bloc.dart';

sealed class AllBundlesEvent {
  const AllBundlesEvent();
}


class BundlesFetched extends AllBundlesEvent {
  final List<Bundle> bundles;
  const BundlesFetched(this.bundles);
}

class BundlesLoading extends AllBundlesEvent {
  const BundlesLoading();
}

class BundlesIsEmpty extends AllBundlesEvent {
  const BundlesIsEmpty();
}

class BundlesError extends AllBundlesEvent {
  const BundlesError();
}
