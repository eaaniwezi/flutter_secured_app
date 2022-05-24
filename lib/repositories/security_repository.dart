// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_keychain/flutter_keychain.dart';

class SecurityRepository {
  SharedPreferences? preferences;
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

  Future<bool> isFirstTimeWrongPassword() async {
    preferences = await SharedPreferences.getInstance();
    var firstTime = preferences!.getBool("first_time_error");
    if (firstTime == null) {
      preferences!.setBool("first_time_error", false);
      await FlutterKeychain.put(key: "initialCount", value: 4.toString());
      return true;
    } else {
      preferences!.setBool("first_time_error", false);
      return false;
    }
  }

  Future<int> numberOfTrials() async {
    var isFirstTIme = await isFirstTimeWrongPassword();
    if (isFirstTIme == true) {
      return 4;
    } else {
      var initialCount = await FlutterKeychain.get(key: "initialCount");
      var remains = int.parse(initialCount!) - 1;
      await FlutterKeychain.put(key: "initialCount", value: remains.toString());
      return remains;
    }
  }

  Future<void> blockAccount({required String isBlocked}) async {
    await FlutterKeychain.put(key: "isBlocked", value: isBlocked);
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
      isFirstTimeWrongPassword();
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
