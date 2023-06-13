import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/src/firebase_collection_name.dart';
import '../../../utils/src/firebase_field_name.dart';
import '../../AuthScreen/Provider/auth_provider.dart';
import '../../home/post/models/post_response_model.dart';
import '../../home/post/post_constants.dart';

final userPostsProvider = StreamProvider.autoDispose<Iterable<Post>>(
  (ref) {
    final userId = ref.watch(userIdProvider);

    final controller = StreamController<Iterable<Post>>();

    controller.onListen = () {
      controller.sink.add([]);
    };

    /// watch user Posts
    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.posts,
        )
        .orderBy(
          FireBaseFieldName.createdAt,
          descending: true,
        )
        .where(
          PostKey.userId,
          isEqualTo: userId,
        )
        .snapshots()
        .listen(
      (snapshot) {
        final documents = snapshot.docs;

        final posts = documents
            .where(
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map(
              (doc) => Post(
                postId: doc.id,
                json: doc.data(),
              ),
            );
        controller.sink.add(posts);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);
