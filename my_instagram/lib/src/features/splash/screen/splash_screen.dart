// import '../../src/ui_utils/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../providers/app_providers.dart';
import '../../../routing/route_constants.dart';
import '../../../services/connectivity_service_provider.dart/connectivity_service_provider.dart';
import '../../../ui_utils/app_snack_bar.dart';
import '../../../ui_utils/loading_screen.dart';
import '../../../utils/utils.dart';
import '../../../constants/string_constants.dart';
import '../../AuthScreen/Provider/auth_provider.dart';

class SplashScreen extends StatefulHookConsumerWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    ref.listen<AsyncValue<ConnectionStatus>>(
      connectionStreamProvider,
      (prevState, newState) {
        newState.whenOrNull(
          data: (status) {
            String message = status == ConnectionStatus.disconnected
                ? 'Your Disconnected'
                : 'Your Back Online';
            AppSnackBar(isPositive: true, message: message)
                .showAppSnackBar(context);
          },
        );
      },
    );
    ref.listen(isLoadingProvider, (_, isLoading) {
      if (isLoading) {
        return LoadingScreen.instance().show(context: context);
      } else {
        return LoadingScreen.instance().hide();
      }
    });

    return Scaffold(
      body: Container(
          color: AppColors.primaryColor,
          child: Center(child: Text(StringConstants.appName.tr(context)))),
    );
  }

  void _moveToNextPage() {
    final isLoggedIn = ref.watch(isLoggedInProvider);

    if (isLoggedIn) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          RouteConstants.homeScreen, (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
          RouteConstants.loginScreen, (Route<dynamic> route) => false);
    }
  }

  void _startTimer() async {
    Future.delayed(const Duration(seconds: 1), _moveToNextPage);
  }
}
