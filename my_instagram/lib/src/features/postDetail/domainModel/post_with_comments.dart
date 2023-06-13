import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:my_instagram/src/features/home/post/models/post_response_model.dart';

import '../../home/post/models/comment_response_model.dart';

@immutable
class PostWithComments {
  final Post post;
  final Iterable<Comment> comments;

  const PostWithComments({
    required this.post,
    required this.comments,
  });

  @override
  bool operator ==(covariant PostWithComments other) =>
      post == other.post &&
      const IterableEquality().equals(
        comments,
        other.comments,
      );

  @override
  int get hashCode => Object.hashAll([
        post,
        comments,
      ]);
}
