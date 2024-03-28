import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'config_provider.g.dart';

@riverpod
class Config extends _$Config {
  @override
  Future<SharedPreferences> build() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref;
  }

  Future setConfig() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('resSort') == null) {
      await pref.setBool('resSort', true);
    }

    if (pref.getString('threadSort') == null) {
      await pref.setString('threadSort', 'createdAt');
    }

    if (pref.getBool('isMyThreads') == null) {
      await pref.setBool('isMyThreads', false);
    }
    if (pref.getString('handleName') == null) {
      await pref.setString('handleName', '名無しさん');
    }
  }

  Future<bool> getConfig() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('resSort') == null) {
      return false;
    }

    if (pref.getString('threadSort') == null) {
      return false;
    }

    if (pref.getBool('isMyThreads') == null) {
      return false;
    }
    if (pref.getString('handleName') == null) {
      return false;
    }
    return true;
  }

  Future remove() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('resSort');
    await pref.remove('threadSort');
    await pref.remove('handleName');
    await pref.remove('isMyThreads');
  }
}
