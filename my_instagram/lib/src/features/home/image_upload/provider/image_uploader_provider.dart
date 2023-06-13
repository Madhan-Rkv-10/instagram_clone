import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/utils.dart';
import '../notifier/image_upload_notifier.dart';

final imageUploadProvider =
    StateNotifierProvider<ImageUploadNotifier, LoadingState>(
        (ref) => ImageUploadNotifier());
