import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/utils.dart';
import '../notifier/send_comment_notifier.dart';

final sendCommentProvider =
    StateNotifierProvider<SendCommentNotifier, LoadingState>(
  (ref) => SendCommentNotifier(),
);
