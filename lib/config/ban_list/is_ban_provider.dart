import 'package:app_55hz/config/ban_list/ban_list_provider.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_ban_provider.g.dart';

@riverpod
class IsBan extends _$IsBan {
  @override
  Future<bool> build() async {
    final banList = await ref.watch(banListProvider.future);
    final udid = await FlutterUdid.udid;
    final isBan = banList.contains(udid);

    return isBan;
  }
}
