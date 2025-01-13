import 'package:GoDeli/features/cart/infraestructure/models/bundle_cart_entity.dart';
import 'package:GoDeli/features/cart/infraestructure/models/product_cart_entity.dart';
import 'package:GoDeli/features/products/infraestructure/models/product_entity.dart';
import 'package:GoDeli/features/bundles/infraestructure/models/bundle_entity.dart';
import 'package:GoDeli/features/auth/infrastructure/models/auth_token_entity.dart';


import 'package:path_provider/path_provider.dart';


import 'package:isar/isar.dart';

class IsarLocalStorage {
  late Future<Isar> _db;

  IsarLocalStorage() {
    _db = openIsar();
  }

  Future<Isar> openIsar() async {
    // Verifica si ya existe una instancia abierta
    final existingInstance = Isar.getInstance();
    if (existingInstance != null) {
      return Future.value(existingInstance);
    }

    final dir = await getApplicationDocumentsDirectory();
    // Si no hay instancia abierta, abre una nueva
    return await Isar.open([
      AuthTokenEntitySchema,
      ProductCartEntitySchema,
      ProductEntitySchema,
      BundleEntitySchema,
      BundleCartEntitySchema
    ], directory: dir.path);
  }

  get db => _db;
}