// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../ui_utils/animations/small_error_animation_view.dart';
import '../../../AuthScreen/Provider/user_info_provider.dart';
import '../../../home/post/models/comment_response_model.dart';
import '../../../home/presentaion/widgets/rich_two_parts_text.dart';

class CompactCommentTile extends ConsumerWidget {
  const CompactCommentTile({required this.comment, Key? key}) : super(key: key);
  final Comment comment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoModelProvider(comment.fromUserId));

    return userInfo.when(
      data: (userInfoDetails) {
        return RichTwoPartsText(
            leftPart: userInfoDetails.displayName, rightPart: comment.comment);
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
