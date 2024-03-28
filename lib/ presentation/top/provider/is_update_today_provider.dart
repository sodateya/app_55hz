import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_update_today_provider.g.dart';

@riverpod
bool isUpdateToday(IsUpdateTodayRef ref, DateTime upDateAt) {
  final isUpdateToday = '${upDateAt.year}/${upDateAt.month}/${upDateAt.day}' ==
      '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}';
  return isUpdateToday;
}
