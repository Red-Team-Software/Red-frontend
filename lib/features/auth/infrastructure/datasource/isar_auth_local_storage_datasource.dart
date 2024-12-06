import 'package:GoDeli/config/locar_storage/isar_local_storage.dart';
import 'package:GoDeli/features/auth/application/datasources/auth_local_storage_datasource.dart';
import 'package:GoDeli/features/auth/infrastructure/models/auth_token_entity.dart';
import 'package:isar/isar.dart';

class IsarAuthLocalStorageDatasource implements IAuthLocalStorageDataSource {
  final IsarLocalStorage _isarLocalStorage;

  IsarAuthLocalStorageDatasource(this._isarLocalStorage);

  @override
  Future<void> saveToken(String token, {DateTime? expiresAt}) async {
    final Isar isar = await _isarLocalStorage.db;
    final authToken = AuthTokenEntity()
      ..token = token
      ..createdAt = DateTime.now()
      ..expiresAt = expiresAt;

    await isar.writeTxn(() async {
      await isar.authTokenEntitys.put(authToken);
    });
  }

  @override
  Future<void> deleteToken() async {
    final Isar isar = await _isarLocalStorage.db;

    await isar.writeTxn(() async {
      // Recuperar todas las entidades
      final ids = await isar.authTokenEntitys.where().idProperty().findAll();
      // Eliminar todas las entidades por sus IDs
      await isar.authTokenEntitys.deleteAll(ids);
    });
  }

  @override
  Future<String> getToken() async {
    final Isar isar = await _isarLocalStorage.db;

    final token = await isar.authTokenEntitys.where().findFirst();
    if (token != null && _isValid(token)) {
      return token.token;
    }
    return ''; // Token inválido o no encontrado
  }

  bool _isValid(AuthTokenEntity token) {
    if (token.expiresAt == null) return true; // Sin expiración definida
    return DateTime.now().isBefore(token.expiresAt!);
  }
}
