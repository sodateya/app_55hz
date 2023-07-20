import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditModel extends ChangeNotifier {
  String? handleName;

  Future getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (pref.getString('handleName') == null) {
      await pref.setString('handleName', '名無しさん');
      handleName = pref.getString('handleName');
    } else {
      handleName = pref.getString('handleName');
    }
    notifyListeners();
  }

  Future setName(String name) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (name.isEmpty) {
      throw ('ハンドルネームを入力してください');
    } else {
      await pref.setString('handleName', name);
    }
    notifyListeners();
  }

  Future clearDb() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
