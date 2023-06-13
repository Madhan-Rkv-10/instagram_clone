import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_instagram/src/features/home/presentaion/widgets/rich_two_parts_text.dart';

import '../../../../ui_utils/animations/small_error_animation_view.dart';
import '../../../AuthScreen/Provider/user_info_provider.dart';
import '../../../home/post/models/post_response_model.dart';

class PostDisplayNameAndMessageView extends ConsumerWidget {
  final Post post;
  const PostDisplayNameAndMessageView({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoModel = ref.watch(
      userInfoModelProvider(post.userId),
    );
    return userInfoModel.when(
      data: (userInfoModel) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichTwoPartsText(
            leftPart: userInfoModel.displayName,
            rightPart: post.message,
          ),
        );
      },
      error: (error, stackTrace) {
        return const SmallErrorAnimationView();
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
