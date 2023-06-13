// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../ui_utils/animations/small_error_animation_view.dart';
import '../../../../utils/utils.dart';
import '../../../AuthScreen/Provider/auth_provider.dart';
import '../../../home/image_upload/models/likes_dislikes_request.dart';
import '../../../home/image_upload/provider/has_liked_post_provider.dart';
import '../../../home/image_upload/provider/like_dislike_post_provider.dart';

class LikeButton extends ConsumerWidget {
  const LikeButton({
    Key? key,
    required this.postId,
  }) : super(key: key);
  final PostId postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLiked = ref.watch(hasLikedPostProvider(postId));
    return hasLiked.when(
        data: (liked) {
          return IconButton(
              onPressed: () {
                final userId = ref.read(userIdProvider);

                if (userId == null) {
                  return;
                }
                final likeRequest =
                    LikeDislikeRequest(postId: postId, uerId: userId);
                ref.read(likeDislikeProvider(likeRequest));
              },
              icon: Icon(liked ? Icons.favorite : Icons.favorite_border));
        },
        error: (error, stracktrance) {
          return const SmallErrorAnimationView();
        },
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
