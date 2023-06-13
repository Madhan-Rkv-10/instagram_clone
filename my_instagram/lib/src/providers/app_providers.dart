import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/AuthScreen/Provider/auth_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.isLoading;
});
