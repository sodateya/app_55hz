import 'package:app_55hz/model/talk/talk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'talk_to_admin_ref_provider.g.dart';

@riverpod
CollectionReference<Talk> talkToAdminRef(TalkToAdminRefRef ref) {
  return FirebaseFirestore.instance.collection('inquiry').withConverter<Talk>(
        fromFirestore: (snapshot, _) => Talk.fromJson(snapshot.data()!),
        toFirestore: (product, _) => product.toJson(),
      );
}

//test aa