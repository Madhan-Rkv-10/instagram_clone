import 'package:flutter/material.dart';
import 'package:my_instagram/src/features/home/presentaion/widgets/post_image_view.dart';
import 'package:my_instagram/src/features/home/presentaion/widgets/post_video_view.dart';

import '../../../../utils/src/extensions/file_type.dart';
import '../../post/models/post_response_model.dart';

class PostImageOrVideoView extends StatelessWidget {
  final Post post;
  const PostImageOrVideoView({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    switch (post.fileType) {
      case FileType.image:
        return PostImageView(
          post: post,
        );
      case FileType.video:
        return PostVideoView(
          post: post,
        );
      default:
        return const SizedBox();
    }
  }
}
