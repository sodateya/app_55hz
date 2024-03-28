import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ban_list_provider.g.dart';

@riverpod
class BanList extends _$BanList {
  @override
  Future<List> build() async {
    final doc = await FirebaseFirestore.instance
        .collection('config')
        .doc('config')
        .get();
    final banList = doc.data()!['banList'];
    return banList;
  }
}
