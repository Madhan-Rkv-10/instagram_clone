import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_instagram/src/features/home/presentaion/widgets/post_grid_view.dart';

import '../../../ui_utils/animations/empty_content_with_text_animation_view.dart';
import '../../../ui_utils/animations/error_animation_view.dart';
import '../../../ui_utils/animations/loading_animation_view.dart';
import '../../../utils/src/constants.dart';
import '../provider/user_posts_provider.dart';

class UserPostsView extends ConsumerWidget {
  const UserPostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userPostsProvider);
    return RefreshIndicator(
      onRefresh: () {
        // ignore: unused_result
        ref.refresh(userPostsProvider);
        return Future.delayed(
          const Duration(
            seconds: 1,
          ),
        );
      },
      child: posts.when(
        data: (posts) {
          // print(posts.length)
          if (posts.isEmpty) {
            return const EmptyContentWithTextAnimationView(
              text: Strings.youHaveNoPosts,
            );
          } else {
            return PostsGridView(
              posts: posts,
            );
          }
        },
        error: (error, stackTrace) {
          return const ErrorAnimationView();
        },
        loading: () {
          return const LoadingAnimationView();
        },
      ),
    );
  }
}
