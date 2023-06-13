import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_instagram/src/utils/src/extensions/soting_comments.dart';

import '../../../utils/src/firebase_collection_name.dart';
import '../../../utils/src/firebase_field_name.dart';
import '../../home/post/models/comment_response_model.dart';
import '../../home/post/models/post_and_coment_request_model.dart';
import '../../home/post/models/post_response_model.dart';
import '../domainModel/post_with_comments.dart';

final specificPostWithCommentsProvider = StreamProvider.family
    .autoDispose<PostWithComments, RequestForPostAndComments>((
  ref,
  RequestForPostAndComments request,
) {
  final controller = StreamController<PostWithComments>();

  Post? post;
  Iterable<Comment>? comments;

  void notify() {
    final localPost = post;
    if (localPost == null) {
      return;
    }

    final outputComments = (comments ?? []).applySortingFrom(request);

    final result = PostWithComments(
      post: localPost,
      comments: outputComments,
    );
    controller.sink.add(result);
  }

  // watch changes to the post

  final postSub = FirebaseFirestore.instance
      .collection(
        FirebaseCollectionName.posts,
      )
      .where(
        FieldPath.documentId,
        isEqualTo: request.postId,
      )
      .limit(1)
      .snapshots()
      .listen(
    (snapshot) {
      if (snapshot.docs.isEmpty) {
        post = null;
        comments = null;
        notify();
        return;
      }
      final doc = snapshot.docs.first;
      if (doc.metadata.hasPendingWrites) {
        return;
      }
      post = Post(
        postId: doc.id,
        json: doc.data(),
      );
      notify();
    },
  );

  // watch changes to the comments

  final commentsQuery = FirebaseFirestore.instance
      .collection(
        FirebaseCollectionName.comments,
      )
      .where(
        FireBaseFieldName.postId,
        isEqualTo: request.postId,
      )
      .orderBy(
        FireBaseFieldName.createdAt,
        descending: true,
      );

  final limitedCommentsQuery = request.limit != null
      ? commentsQuery.limit(request.limit!)
      : commentsQuery;
  final commentsSub = limitedCommentsQuery.snapshots().listen(
    (snapshot) {
      comments = snapshot.docs
          .where(
            (doc) => !doc.metadata.hasPendingWrites,
          )
          .map(
            (doc) => Comment(
              doc.data(),
              id: doc.id,
            ),
          );
      notify();
    },
  );

  ref.onDispose(() {
    postSub.cancel();
    commentsSub.cancel();
    controller.close();
  });

  return controller.stream;
});
