import 'package:GoDeli/features/bundles/domain/bundle.dart';
import 'package:GoDeli/features/bundles/infraestructure/mappers/bundle_entity_mapper.dart';
import 'package:GoDeli/features/bundles/infraestructure/models/bundle_entity.dart';
import 'package:GoDeli/features/cart/domain/bundle_cart.dart';
import 'package:GoDeli/features/cart/domain/datasource/local_storage_datasource.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:GoDeli/features/cart/infraestructure/mappers/bundle_cart_entity_mapper.dart';
import 'package:GoDeli/features/cart/infraestructure/mappers/product_cart_entity_mapper.dart';
import 'package:GoDeli/features/cart/infraestructure/models/bundle_cart_entity.dart';
import 'package:GoDeli/features/cart/infraestructure/models/product_cart_entity.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/features/products/infraestructure/mappers/product_entity_mapper.dart';
import 'package:GoDeli/features/products/infraestructure/models/product_entity.dart';
import 'package:GoDeli/presentation/widgets/widgets.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarLocalStorageDatasource extends LocalStorageDataSource {
  late Future<Isar> db;

  IsarLocalStorageDatasource() {
    db = openIsar();
  }

  Future<Isar> openIsar() async {
    // Verifica si ya existe una instancia abierta
    final existingInstance = Isar.getInstance();
    if (existingInstance != null) {
      return Future.value(existingInstance);
    }

    final dir = await getApplicationDocumentsDirectory();
    // Si no hay instancia abierta, abre una nueva
    return await Isar.open([ProductCartEntitySchema, ProductEntitySchema, BundleEntitySchema, BundleCartEntitySchema], directory: dir.path);
  }

  @override
  Future<void> clearCart() async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.productCartEntitys.clear();
      await isar.bundleCartEntitys.clear();
    });
  }

  @override
  Future<List<ProductCart>> getCartItems() async {
    final isar = await db;

    // Obtén todos los ProductCartEntity almacenados en la base de datos
    final productCartEntities = await isar.productCartEntitys.where().findAll();

    // Cargar enlaces de productos en cada ProductCartEntity
    for (var entity in productCartEntities) {
      await entity.product.load();
    }

    // Mapear cada ProductCartEntity al dominio ProductCart
    final cartProducts = productCartEntities
        .map((entity) => ProductCartEntityMapper().mapProductCartToDomain(entity))
        .toList();

    // Obtén todos los BundleCartEntity almacenados en la base de datos
    final bundleCartEntities = await isar.bundleCartEntitys.where().findAll();

    // Cargar enlaces de bundles en cada BundleCartEntity
    for (var entity in bundleCartEntities) {
      await entity.bundle.load();
    }

    // Mapear cada BundleCartEntity al dominio BundleCart
    final cartBundles = bundleCartEntities
        .map((entity) => BundleCartEntityMapper().mapBundleCartToDomain(entity))
        .toList();

    // Retorna la lista combinada de ProductCart y BundleCart
    dynamic cart = [...cartProducts, ...cartBundles];


    return cart;
  }

  @override
  Future<void> addProductToCart(ProductCart product) async {
    // Asegura que el producto esté en la base de datos, obteniendo o guardando si es necesario
    final productEntity = await _saveProductIfNotExists(product.product);

    // Mapea el ProductCart al ProductCartEntity y asigna el enlace al producto
    final productCartEntity = ProductCartEntityMapper().mapProductCartToEntity(product);
    productCartEntity.product.value = productEntity;

    // Guarda el ProductCartEntity con el enlace al producto
    await _saveProductCartEntity(productCartEntity);
  }
  
  @override
  Future<void> updateProductQuantity(String productId, int newQuantity) async {
    final isar = await db;

    // Busca el ProductCartEntity por el ID del producto
    final productCartEntity = await isar.productCartEntitys
        .filter()
        .product((q) => q.idEqualTo(productId))
        .findFirst();

    if (productCartEntity != null) {
      // Actualiza la cantidad
      productCartEntity.quantity = newQuantity;

      // Guarda el cambio en la base de datos
      await isar.writeTxn(() async {
        await isar.productCartEntitys.put(productCartEntity);
      });
    }
  }

  @override
  Future<void> removeProductFromCart(ProductCart product) async {
    final isar = await db;

    // Obtén el ProductEntity correspondiente al producto en ProductCart
    final productEntity = await _getProductById(product.product.id);

    // Si el producto no existe, no hay nada que eliminar en el carrito
    if (productEntity == null) return;

    // Busca el ProductCartEntity que contiene el enlace al ProductEntity encontrado
    final productCartEntity = await isar.productCartEntitys
        .filter()
        .product((q) => q.idEqualTo(product.product.id))
        .findFirst();

    // Si el carrito existe con ese producto, elimínalo
    if (productCartEntity != null) {
      await isar.writeTxn(() async {
        await isar.productCartEntitys.delete(productCartEntity.isarId!);
      });
    }
  }


  Future<ProductEntity?> _getProductById(String productId) async {
    final isar = await db;
    return await isar.productEntitys
        .filter()
        .idEqualTo(productId)
        .findFirst();
  }

  Future<ProductEntity> _saveProductIfNotExists(Product product) async {
    final existingProductEntity = await _getProductById(product.id);

    // Si el producto ya existe, retorna la entidad existente
    if (existingProductEntity != null) {
      return existingProductEntity;
    }

    // Si no existe, mapea y guarda un nuevo ProductEntity
    final newProductEntity = ProductEntityMapper().mapProductToEntity(product);
    final isar = await db;

    await isar.writeTxn(() async {
      await isar.productEntitys.put(newProductEntity);
    });

    return newProductEntity;
  }

  Future<void> _saveProductCartEntity(ProductCartEntity productCartEntity) async {
    final isar = await db;
    
    await isar.writeTxn(() async {
      await isar.productCartEntitys.put(productCartEntity);
      await productCartEntity.product.save(); // Asegura que el enlace esté guardado
    });
  }

  Future<BundleEntity?> _getBundleById(String bundleId) async {
    final isar = await db;
    return await isar.bundleEntitys
        .filter()
        .idEqualTo(bundleId)
        .findFirst();
  }

  Future<BundleEntity> _saveBundleIfNotExists(Bundle bundle) async {
    final existingBundleEntity = await _getBundleById(bundle.id);

    // Si el bundle ya existe, retorna la entidad existente
    if (existingBundleEntity != null) {
      return existingBundleEntity;
    }

    // Si no existe, mapea y guarda un nuevo BundleEntity
    final newBundleEntity = BundleEntityMapper().mapBundleToEntity(bundle);
    final isar = await db;

    await isar.writeTxn(() async {
      await isar.bundleEntitys.put(newBundleEntity);
    });

    return newBundleEntity;
  }

  Future<void> _saveBundleCartEntity(BundleCartEntity bundleCartEntity) async {
    final isar = await db;
    
    await isar.writeTxn(() async {
      await isar.bundleCartEntitys.put(bundleCartEntity);
      await bundleCartEntity.bundle.save(); // Asegura que el enlace esté guardado
    });
  }

  @override
  Future<void> addBundleToCart(BundleCart bundle) async {
    // Asegura que el bundle esté en la base de datos, obteniendo o guardando si es necesario
    final bundleEntity = await _saveBundleIfNotExists(bundle.bundle);

    // Mapea el BundleCart al BundleCartEntity y asigna el enlace al bundle
    final bundleCartEntity = BundleCartEntityMapper().mapBundleCartToEntity(bundle);
    bundleCartEntity.bundle.value = bundleEntity;

    // Guarda el BundleCartEntity con el enlace al bundle
    await _saveBundleCartEntity(bundleCartEntity);

    print('Bundle added to cart: ${bundle.bundle.name}');
  }

  @override
  Future<void> removeBundleFromCart(BundleCart bundle) async {

    final isar = await db;

    // Obtén el BundleEntity correspondiente al bundle en BundleCart
    final bundleEntity = await _getBundleById(bundle.bundle.id);

    // Si el bundle no existe, no hay nada que eliminar en el carrito
    if (bundleEntity == null) return;

    // Busca el BundleCartEntity que contiene el enlace al BundleEntity encontrado
    final bundleCartEntity = await isar.bundleCartEntitys
        .filter()
        .bundle((q) => q.idEqualTo(bundle.bundle.id))
        .findFirst();

    // Si el carrito existe con ese bundle, elimínalo
    if (bundleCartEntity != null) {
      await isar.writeTxn(() async {
        await isar.bundleCartEntitys.delete(bundleCartEntity.isarId!);
      });
    }

  }
  
  @override
  Future<void> updateBundleQuantity(String bundleId, int newQuantity) async {
    
    final isar = await db;

    // Busca el BundleCartEntity por el ID del bundle
    final bundleCartEntity = await isar.bundleCartEntitys
        .filter()
        .bundle((q) => q.idEqualTo(bundleId))
        .findFirst();

    if (bundleCartEntity != null) {
      // Actualiza la cantidad
      bundleCartEntity.quantity = newQuantity;

      // Guarda el cambio en la base de datos
      await isar.writeTxn(() async {
        await isar.bundleCartEntitys.put(bundleCartEntity);
      });
    }

  }
  
}
