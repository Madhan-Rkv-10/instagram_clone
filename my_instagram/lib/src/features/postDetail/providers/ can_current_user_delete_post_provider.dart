// ignore_for_file: file_names

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../AuthScreen/Provider/auth_provider.dart';
import '../controller/post_setting_controller.dart';
import '../../home/post/models/post_response_model.dart';
import '../../home/post/post_utils.dart';

// /To Check the whether the post have delete option
final canCurrentUserDeletePostProvider =
    StreamProvider.autoDispose.family<bool, Post>(
  (ref, Post post) async* {
    ///watch use user to delete post
    final userId = ref.watch(userIdProvider);
    yield userId == post.userId;
  },
);

final postSettingProvider =
    StateNotifierProvider<PostSettingNotifier, Map<PostSetting, bool>>((ref) {
  return PostSettingNotifier();
});
