import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/bundles/infraestructure/models/bundle_response.dart';


class BundleMapper {
  static Bundle bundleToDomian(BundleResponse json) {
    return Bundle(
      id: json.id,
      name: json.name,
      description: json.description,
      price: json.price,
      currency: json.currency,
      imageUrl: json.images,
      weight: json.weight,
      measurement: json.measurement,
      inStock: json.stock,
      expirationDate: json.caducityDate,
      categories: json.categories,
      promotions: json.promotion,
      products: json.products
    );
  }
}
