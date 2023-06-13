import 'package:flutter/foundation.dart' show immutable;
import 'dart:collection' show MapView;

import '../../../utils/src/firebase_field_name.dart';
import '../../../utils/utils.dart';

@immutable
class UserInfoPayLoad extends MapView<String, String> {
  UserInfoPayLoad(
      {required UserId userId,
      required String? displayName,
      required String? email})
      : super({
          FireBaseFieldName.userId: userId,
          FireBaseFieldName.displayName: displayName ?? '',
          FireBaseFieldName.email: email ?? '',
        });
}
