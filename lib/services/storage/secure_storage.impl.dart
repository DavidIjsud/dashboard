import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:petshopdashboard/constants/securestorage_constants.dart';
import 'package:petshopdashboard/services/storage/secure_storage.dart';

class SecureStorageImpl implements SecureStorage {
  SecureStorageImpl() : _secureStorage = const FlutterSecureStorage();
  final FlutterSecureStorage _secureStorage;

  @override
  Future<String?> getSessionId() async {
    return await _secureStorage.read(key: SecureStorageConstants.sessionId);
  }

  @override
  Future<void> setSessionId(String sessionId) async {
    await _secureStorage.write(
      key: SecureStorageConstants.sessionId,
      value: sessionId,
    );
  }
}
