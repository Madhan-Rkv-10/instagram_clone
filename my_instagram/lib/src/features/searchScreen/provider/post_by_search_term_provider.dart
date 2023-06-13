import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/src/firebase_collection_name.dart';
import '../../../utils/src/firebase_field_name.dart';
import '../../../utils/utils.dart';
import '../../home/post/models/post_response_model.dart';

final postBysearchTermprovider =
    StreamProviderFamily<Iterable<Post>, SearchTerm>((ref, searchTerm) {
  final controller = StreamController<Iterable<Post>>();

  ///posts based on  search comment
  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .orderBy(FireBaseFieldName.createdAt, descending: true)
      .snapshots()
      .listen((event) {
    final post = event.docs
        .map((doc) => Post(postId: doc.id, json: doc.data()))
        .where((element) =>
            element.message.toLowerCase().contains(searchTerm.toLowerCase()));
    controller.sink.add(post);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
