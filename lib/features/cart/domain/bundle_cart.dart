

import 'package:GoDeli/features/bundles/domain/bundle.dart';

class BundleCart {
  final Bundle bundle;
  final int quantity;

  BundleCart({
    required this.bundle,
    required this.quantity,
  });

  BundleCart copyWith({
    Bundle? bundle,
    int? quantity,
  }) {
    return BundleCart(
      bundle: bundle ?? this.bundle,
      quantity: quantity ?? this.quantity,
    );
  }
}