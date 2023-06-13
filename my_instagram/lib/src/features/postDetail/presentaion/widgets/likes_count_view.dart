// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../ui_utils/animations/loading_animation_view.dart';
import '../../../../ui_utils/animations/small_error_animation_view.dart';
import '../../../../utils/src/constants.dart';
import '../../../../utils/utils.dart';
import '../../../home/image_upload/provider/post_likes_count_provider.dart';

class LikesCountView extends HookConsumerWidget {
  final PostId postId;
  const LikesCountView({required this.postId, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesCount = ref.watch(
      postLikesCountProvider(
        postId,
      ),
    );
    return likesCount.when(
      data: (int likesCount) {
        final personOrpeople =
            likesCount == 1 ? Strings.person : Strings.people;
        final likesText = '$likesCount $personOrpeople ${Strings.likedThis}';
        return Text(likesText);
      },
      loading: () {
        return const LoadingAnimationView();
      },
      error: (error, stackTrace) {
        return const SmallErrorAnimationView();
      },
    );
  }
}
