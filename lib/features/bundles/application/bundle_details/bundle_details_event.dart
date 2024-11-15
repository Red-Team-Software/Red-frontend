part of 'bundle_details_bloc.dart';

sealed class BundleDetailsEvent {
  const BundleDetailsEvent();

}

class BundleLoaded extends BundleDetailsEvent{
  final Bundle bundle;
  const BundleLoaded({required this.bundle});
}

class LoadingStarted extends BundleDetailsEvent{}

class ErrorOnBundleLoading extends BundleDetailsEvent{}