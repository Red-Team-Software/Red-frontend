part of 'bundle_details_bloc.dart';

sealed class BundleDetailsState extends Equatable {
  const BundleDetailsState();
  
  @override
  List<Object> get props => [];
}

final class BundleDetailsInitial extends BundleDetailsState {}
