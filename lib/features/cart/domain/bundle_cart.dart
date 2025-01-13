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

  factory BundleCart.fromJson(Map<String, dynamic> json) {
    return BundleCart(
      bundle: Bundle(
        id: json['id'] as String,
        name: (json['nombre'] ?? json['name']) as String,
        description: json['descripcion'] as String,
        price: (json['price'] as num).toDouble(),
        currency: json['currency'] as String,
        imageUrl: List<String>.from(json['images'] ?? []),
      ),
      quantity: json['quantity'] as int,
    );
  }
}
