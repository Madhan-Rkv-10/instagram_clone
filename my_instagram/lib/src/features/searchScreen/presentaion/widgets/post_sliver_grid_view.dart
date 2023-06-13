import 'package:flutter/material.dart';
import 'package:my_instagram/src/features/home/presentaion/widgets/post_thumbnail_view.dart';
import 'package:my_instagram/src/routing/route_constants.dart';
import '../../../home/post/models/post_response_model.dart';

class PostsSliverGridView extends StatelessWidget {
  final Iterable<Post> posts;
  const PostsSliverGridView({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      delegate: SliverChildBuilderDelegate(
        childCount: posts.length,
        (context, index) {
          final post = posts.elementAt(index);
          return PostThumbnailView(
            post: post,
            onTapped: () {
              Navigator.pushNamed(context, RouteConstants.postDetail,
                  arguments: {'post': post});
            },
          );
        },
      ),
    );
  }
}
