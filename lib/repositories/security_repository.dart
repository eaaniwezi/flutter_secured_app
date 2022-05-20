// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecurityRepository {
  final storage = FlutterSecureStorage();

  Future<void> setPinCode({required String pinCode}) async {}
}
