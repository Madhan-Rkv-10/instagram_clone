import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../firebase_options.dart';
import 'local_storage/key_value_storage_base.dart';

final servicesInitializerProvider = Provider<ServicesInitializer>((ref) {
  return ServicesInitializer(ref);
});

class ServicesInitializer {
  ServicesInitializer(this.ref);
  final Ref ref;
  Future<void> init() async {
    await _initKeyValueStorage();
    await _initFirebase();
  }

  Future<void> _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    //! Need Setup a Foreground Push Notification
  }

  Future<void> _initKeyValueStorage() async {
    await KeyValueStorageBase.init();
  }
}
