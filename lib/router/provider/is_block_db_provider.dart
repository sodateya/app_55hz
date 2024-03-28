import 'package:app_55hz/%20presentation/block/provider/block_ref_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_block_db_provider.g.dart';

@riverpod
FutureOr<bool> isBlockDb(IsBlockDbRef ref) async {
  final doc = await ref.watch(blockRefProvider).get();

  return doc.data() != null;
}
