import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/utils.dart';
import '../Repository/auth_repo.dart';
import '../Repository/user_info_storage_repo.dart';
import '../Utils/auth_enums.dart';
import '../domainModel/auth_state_model.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();
  AuthStateNotifier() : super(const AuthState.unKnown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
          result: AuthResult.success,
          isLoading: false,
          userId: _authenticator.userId);
    }
  }
  Future<void> logOut() async {
    state = state.copyWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unKnown();
  }

  Future<AuthResult> loginWithGoogle() async {
    state = state.copyWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
      return result;
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
    return result;
    // state = state.copyWithIsLoading(false);
  }

  Future<void> loginwithFacebook() async {
    state = state.copyWithIsLoading(true);
    final result = await _authenticator.loginWithFacebook();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> saveUserInfo({required UserId userId}) {
    return _userInfoStorage.saveUserInfo(
      userId: userId,
      displayName: _authenticator.displayName,
      email: _authenticator.email,
    );
  }
}
