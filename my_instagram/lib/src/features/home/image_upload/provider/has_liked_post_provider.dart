import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/src/firebase_collection_name.dart';
import '../../../../utils/src/firebase_field_name.dart';
import '../../../../utils/utils.dart';
import '../../../AuthScreen/Provider/auth_provider.dart';

final hasLikedPostProvider =
    StreamProvider.family.autoDispose<bool, PostId>((ref, postId) {
  final userId = ref.watch(userIdProvider);

  if (userId == null) {
    return Stream<bool>.value(false);
  }
  final controller = StreamController<bool>();
  final subscription = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.likes)
      .where(FireBaseFieldName.postId, isEqualTo: postId)
      .where(FireBaseFieldName.userId, isEqualTo: userId)
      .snapshots()
      .listen((event) {
    if (event.docs.isNotEmpty) {
      controller.add(true);
    } else {
      controller.add(false);
    }
  });
  ref.onDispose(() {
    subscription.cancel();
    controller.close();
  });
  return controller.stream;
});
