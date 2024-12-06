import 'package:isar/isar.dart';

part 'auth_token_entity.g.dart';

@collection
class AuthTokenEntity {
  Id id = Isar.autoIncrement; // Auto-incremental ID
  
  late String token; // Token de autenticación

  DateTime? createdAt; // Fecha de creación del token
  DateTime? expiresAt; // Fecha de expiración del token (opcional)
}