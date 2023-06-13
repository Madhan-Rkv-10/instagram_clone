// final deletePostProvifer=
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/utils.dart';
import '../controller/delete_post_controller.dart';

final deletePostProvider =
    StateNotifierProvider<DeletePostStateNotifier, LoadingState>((
  ref,
) =>
        DeletePostStateNotifier());
