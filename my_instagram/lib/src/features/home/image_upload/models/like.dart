import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../../../../utils/src/firebase_field_name.dart';
import '../../../../utils/utils.dart';

@immutable
class Like extends MapView<String, String> {
  Like({required PostId postId, required likedBy, required DateTime date})
      : super({
          FireBaseFieldName.postId: postId,
          FireBaseFieldName.userId: likedBy,
          FireBaseFieldName.date: date.toIso8601String(),
        });
}
