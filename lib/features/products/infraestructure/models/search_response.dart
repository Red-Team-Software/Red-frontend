import 'package:GoDeli/features/products/infraestructure/models/product_response.dart';

class SearchResponse {
    List<ProductResponse> product;

    SearchResponse({
        required this.product,
    });

    factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        product: List<ProductResponse>.from(json["product"].map((x) => ProductResponse.fromJson(x))),
    );

}
