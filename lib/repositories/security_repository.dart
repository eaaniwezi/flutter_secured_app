// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurityRepository {
  final storage = FlutterSecureStorage();

  Future<bool> setPinCode({required String pinCode}) async {
    // await storage.write(key: 'pinCode', value: pinCode);
    await FlutterKeychain.put(key: "pinCode", value: pinCode);
    return true;
  }
}
