import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/utils.dart';
import '../notifier/delete_comment_notifier.dart';

final deleteCommentProvider =
    StateNotifierProvider<DeleteCommentStateNotifier, LoadingState>(
  (ref) => DeleteCommentStateNotifier(),
);
