import 'package:flutter/material.dart';
import 'package:my_instagram/src/features/home/presentaion/widgets/post_thumbnail_view.dart';
import 'package:my_instagram/src/routing/route_constants.dart';

import '../../post/models/post_response_model.dart';

class PostsGridView extends StatelessWidget {
  final Iterable<Post> posts;

  const PostsGridView({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);
        return PostThumbnailView(
          post: post,
          onTapped: () {
            Navigator.pushNamed(context, RouteConstants.postDetail,
                arguments: {"post": post});
          },
        );
      },
    );
  }
}
