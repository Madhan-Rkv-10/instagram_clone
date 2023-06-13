import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import '../../../utils/src/firebase_collection_name.dart';
import '../../../utils/src/firebase_field_name.dart';
import '../../../utils/utils.dart';
import '../domainModel/user_info_payload_model.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();
  Future<bool> saveUserInfo({
    required UserId userId,
    required String displayName,
    required String? email,
  }) async {
    ///checking user info from before

    try {
      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .where(FireBaseFieldName.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        await userInfo.docs.first.reference.update(
          {
            FireBaseFieldName.displayName: displayName,
            FireBaseFieldName.email: email ?? '',
          },
        );
        return true;
      }

      final payload = UserInfoPayLoad(
        userId: userId,
        displayName: displayName,
        email: email,
      );
      await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .add(
            payload,
          );
      return true;
    } catch (e) {
      return false;
    }
  }
}
