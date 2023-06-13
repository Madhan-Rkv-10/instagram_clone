import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_instagram/src/utils/src/firebase_field_name.dart';

import '../../../../utils/src/firebase_collection_name.dart';
import '../models/post_response_model.dart';

final allPostsProvider = StreamProvider<Iterable<Post>>((ref) {
  final controller = StreamController<Iterable<Post>>();
  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .orderBy(FireBaseFieldName.createdAt, descending: true)
      .snapshots()
      .listen((postData) {
    final post = postData.docs
        .map(
          (e) => Post(
            postId: e.id,
            json: e.data(),
          ),
        )
        .toList();

    controller.sink.add(post);
  });
  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
