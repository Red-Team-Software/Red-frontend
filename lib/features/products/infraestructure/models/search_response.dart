import 'package:GoDeli/features/bundles/infraestructure/models/bundle_response.dart';
import 'package:GoDeli/features/products/infraestructure/models/product_response.dart';

class SearchResponse {
    List<ProductResponse> products;

    SearchResponse({
        required this.products,
    });

    factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        products: List<ProductResponse>.from(json["product"].map((x) => ProductResponse.fromJson(x))),
    );

}