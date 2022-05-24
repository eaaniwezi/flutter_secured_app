// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_keychain/flutter_keychain.dart';

class SecurityRepository {
  final bioMetricsAuth = LocalAuthentication();

  Future<bool> bioMetrics() async {
    final isBioMetricsAvailable = await bioMetricsAuth.isDeviceSupported();

    if (isBioMetricsAvailable == false) return false;
    try {
      return await bioMetricsAuth.authenticate(
          localizedReason: "Сканируйте отпечаток пальца для входа в систему",
          options: AuthenticationOptions(
            biometricOnly: true,
            useErrorDialogs: true,
            stickyAuth: true,
          ));
    } on PlatformException catch (e) {
      return false;
    }
  }

  Future<void> blockAccount({required String isBlocked}) async {
    await FlutterKeychain.put(key: "isBlocked", value: isBlocked);
  }

  Future<int> numberOfTrials({required int numberOfTrials}) async {
    await FlutterKeychain.put(
        key: "numberOfTrials", value: numberOfTrials.toString());
    final savedCounts = await FlutterKeychain.get(key: "numberOfTrials");
    var remains = 4 - int.parse(savedCounts.toString());
    return remains;
  }

  Future<bool> setPinCode({required String pinCode}) async {
    await FlutterKeychain.put(key: "pinCode", value: pinCode);
    return true;
  }

  Future<bool> loginCode({required String pinCode}) async {
    var oldCode = await FlutterKeychain.get(key: "pinCode");
    if (pinCode != oldCode) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> isNewUser() async {
    var oldCode = await FlutterKeychain.get(key: "pinCode");

    if (oldCode == null) {
      return true;
    } else {
      return false;
    }
  }

  List<String> getMnemonics() {
    String mnemonics =
        "Strange Purple Adamant Crayons Entice Fun Eloquent Missiles House Tea Empty Phone";
    List<String> mnemonicsList = mnemonics.split(" ");
    return mnemonicsList;
  }
}
