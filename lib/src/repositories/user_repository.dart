import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  final _storage = new FlutterSecureStorage();

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await _storage.delete(key: 'access_token');
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await _storage.write(key: 'access_token', value: token);

    return;
  }

  Future<String> fetchToken() {
    /// read from keystore/keychain
    return _storage.read(key: 'access_token');
  }
}
