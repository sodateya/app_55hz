import 'package:app_55hz/%20presentation/favorite/provider/favorite_ref_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_favorite_db_provider.g.dart';

@riverpod
FutureOr<bool> isFavorite(IsFavoriteRef ref) async {
  final doc = await ref.watch(favoriteRefProvider).get();
  return doc.data() != null;
}
