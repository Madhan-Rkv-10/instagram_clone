import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_instagram/src/features/home/post/providers/all_post_provider.dart';
import 'package:my_instagram/src/features/home/presentaion/widgets/post_grid_view.dart';

import '../../ui_utils/animations/empty_content_with_text_animation_view.dart';
import '../../ui_utils/animations/error_animation_view.dart';
import '../../ui_utils/animations/loading_animation_view.dart';
import '../../utils/src/constants.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostsProvider);
    return RefreshIndicator(
      onRefresh: () {
        // ignore: unused_result
        ref.refresh(allPostsProvider);
        return Future.delayed(const Duration(seconds: 1));
      },
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentWithTextAnimationView(
              text: Strings.noPostsAvailable,
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
    // return Container();
  }
}
