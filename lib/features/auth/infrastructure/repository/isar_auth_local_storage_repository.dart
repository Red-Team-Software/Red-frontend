

import 'package:GoDeli/features/auth/application/datasources/auth_local_storage_datasource.dart';
import 'package:GoDeli/features/auth/application/repositories/auth_local_storage_repository.dart';

class IsarAuthLocalStorageRepository implements IAuthLocalStorageRepository {
  final IAuthLocalStorageDataSource _dataSource;

  IsarAuthLocalStorageRepository(this._dataSource);

  @override
  Future<void> deleteToken() async {
    await _dataSource.deleteToken();
  }

  @override
  Future<String> getToken() async {
    return await _dataSource.getToken();
  }

  @override
  Future<void> saveToken(String token) async {
    await _dataSource.saveToken(token);
  }
}