import 'package:GoDeli/features/cart/domain/datasource/local_storage_datasource.dart';
import 'package:GoDeli/features/cart/domain/product_cart.dart';
import 'package:GoDeli/features/cart/infraestructure/mappers/product_cart_entity_mapper.dart';
import 'package:GoDeli/features/cart/infraestructure/models/product_cart_entity.dart';
import 'package:GoDeli/features/products/domain/product.dart';
import 'package:GoDeli/features/products/infraestructure/mappers/product_entity_mapper.dart';
import 'package:GoDeli/features/products/infraestructure/models/product_entity.dart';
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
    return await Isar.open([ProductCartEntitySchema, ProductEntitySchema], directory: dir.path);
  }

  @override
  Future<void> clearCart() async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.productCartEntitys.clear();
    });
  }

  @override
  Future<List<ProductCart>> getCartProducts() async {
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

    return cartProducts;
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

  


}
