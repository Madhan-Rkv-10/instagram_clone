// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import '../../../../utils/utils.dart';

@immutable
class LikeDislikeRequest {
  final PostId postId;
  final UserId uerId;
  const LikeDislikeRequest({
    required this.postId,
    required this.uerId,
  });
}
