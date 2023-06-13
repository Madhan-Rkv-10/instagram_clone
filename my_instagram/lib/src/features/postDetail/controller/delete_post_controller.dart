import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_instagram/src/utils/src/extensions/image_extension/get_collection_name_from%20_filetype.dart';
import 'package:my_instagram/src/utils/src/firebase_field_name.dart';

import '../../../utils/src/firebase_collection_name.dart';
import '../../../utils/utils.dart';
import '../../home/post/models/post_response_model.dart';

class DeletePostStateNotifier extends StateNotifier<LoadingState> {
  DeletePostStateNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> deletePost({
    required Post post,
  }) async {
    try {
      isLoading = true;

      ///deleting the file in firebaseStorage
      await FirebaseStorage.instance
          .ref()
          .child(post.userId)
          .child(FirebaseCollectionName.thumbnails)
          .child(post.thumbnailStorageId)
          .delete();

      await FirebaseStorage.instance
          .ref()
          .child(post.userId)
          .child(post.fileType.collectionName)
          .child(post.originalFileStorageId)
          .delete();

      ///delete the comments on specific postId
      await _deleteAllDocuments(
        inCollection: FirebaseCollectionName.comments,
        postId: post.postId,
      );

      ///delete the likes on specific postId

      await _deleteAllDocuments(
        inCollection: FirebaseCollectionName.likes,
        postId: post.postId,
      );

      final postInCollection = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .where(
            FieldPath.documentId,
            isEqualTo: post.postId,
          )
          .limit(1)
          .get();
      for (final post in postInCollection.docs) {
        ///delete  document reference in firestore
        await post.reference.delete();
      }

      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  Future<void> _deleteAllDocuments({
    required PostId postId,
    required String inCollection,
  }) {
    return FirebaseFirestore.instance.runTransaction(
      maxAttempts: 3,
      timeout: const Duration(
        seconds: 20,
      ),
      (transaction) async {
        final query = await FirebaseFirestore.instance
            .collection(inCollection)
            .where(
              FireBaseFieldName.postId,
              isEqualTo: postId,
            )
            .get();
        for (final doc in query.docs) {
          transaction.delete(doc.reference);
        }
      },
    );
  }
}
