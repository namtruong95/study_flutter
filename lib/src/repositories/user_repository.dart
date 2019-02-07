import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:study_flutter/src/global_scope.dart' as globalScope;

class UserRepository {
  static final UserRepository _userRepository = new UserRepository._internal();
  factory UserRepository() => _userRepository;
  UserRepository._internal();

  final _storage = new FlutterSecureStorage();

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await _storage.delete(key: 'access_token');
    await Future.delayed(Duration(milliseconds: 500));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    globalScope.GlobalScope().token = token;

    await _storage.write(key: 'access_token', value: token);

    return;
  }

  Future<String> fetchToken() {
    /// read from keystore/keychain
    return _storage.read(key: 'access_token');
  }
}
