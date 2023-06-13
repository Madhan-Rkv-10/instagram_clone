import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../home/presentaion/widgets/delete_dialog.dart';
import '../../postDetail/presentaion/widgets/compact_comment_column.dart';
import '../../postDetail/presentaion/widgets/like_button.dart';
import '../../postDetail/presentaion/widgets/likes_count_view.dart';
import '../../home/presentaion/widgets/post_image_or_videro_view.dart';
import '../../postDetail/presentaion/widgets/post_display_name_and_message_view.dart';
import '../../../routing/route_constants.dart';
import 'package:my_instagram/src/ui_utils/alert_dialog_model.dart';
import 'package:share_plus/share_plus.dart';
import '../../../ui_utils/animations/error_animation_view.dart';
import '../../../ui_utils/animations/loading_animation_view.dart';
import '../../../ui_utils/animations/small_error_animation_view.dart';
import '../../../utils/src/constants.dart';
import '../../../utils/src/extensions/file_type.dart';
import '../../home/post/models/post_response_model.dart';
import '../../home/post/models/post_and_coment_request_model.dart';
import '../providers/ can_current_user_delete_post_provider.dart';
import '../../home/presentaion/widgets/post_date_view.dart';
import '../providers/delete_post_provider.dart';
import '../providers/specific_post_with_comment_provider.dart';

class PostDetailsView extends ConsumerStatefulWidget {
  final Post post;
  const PostDetailsView({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PostDetailsViewState();
}

class _PostDetailsViewState extends ConsumerState<PostDetailsView> {
  @override
  Widget build(BuildContext context) {
    final request = RequestForPostAndComments(
      postId: widget.post.postId,
      limit: 3,
      sortByCreatedAt: true,
      dateSorting: DateSorting.oldestOnTop,
    );

    final postWithComments = ref.watch(
      specificPostWithCommentsProvider(
        request,
      ),
    );

    final canDeletePost = ref.watch(
      canCurrentUserDeletePostProvider(
        widget.post,
      ),
    );
    // final allPOsts = ref.watch(allPostsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.postDetails,
        ),
        actions: [
          postWithComments.when(
            data: (postWithComments) {
              return IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  final url = postWithComments.post.fileUrl;
                  Share.share(
                    url,
                    subject: Strings.checkOutThisPost,
                  );
                },
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
          ),
          if (canDeletePost.value ?? false)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final shouldDeletePost = await const DeleteDialog(
                        titleOfObjectToDelete: Strings.post)
                    .present(context)
                    .then((shouldDelete) => shouldDelete ?? false);
                if (shouldDeletePost) {
                  await ref
                      .read(deletePostProvider.notifier)
                      .deletePost(post: widget.post);
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
            )
        ],
      ),
      body: postWithComments.when(
        data: (postWithComments) {
          final postId = postWithComments.post.postId;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Text(postWithComments.post),
                PostImageOrVideoView(
                  post: postWithComments.post,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (postWithComments.post.allowsLikes)
                      LikeButton(
                        postId: postId,
                      ),
                    if (postWithComments.post.allowsComments)
                      IconButton(
                        icon: const Icon(
                          Icons.mode_comment_outlined,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              RouteConstants.postComment,
                              arguments: {"postId": postId});
                        },
                      ),
                  ],
                ),
                PostDisplayNameAndMessageView(
                  post: postWithComments.post,
                ),
                PostdateView(
                  dateTime: postWithComments.post.createdAt,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.white70,
                  ),
                ),
                CompactCommentColumn(
                  comments: postWithComments.comments,
                ),
                if (postWithComments.post.allowsLikes)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8),
                    child: LikesCountView(
                      postId: postId,
                    ),
                  ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          );
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
