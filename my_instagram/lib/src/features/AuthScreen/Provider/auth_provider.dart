import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/utils.dart';
import '../Utils/auth_enums.dart';
import '../controller/auth_state_controller.dart';
import '../domainModel/auth_state_model.dart';

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((_) {
  return AuthStateNotifier();
});

final isLoggedInProvider = Provider<bool>(
    (ref) => ref.watch(authStateProvider).result == AuthResult.success);
final userIdProvider =
    Provider<UserId?>((ref) => ref.watch(authStateProvider).userId);
