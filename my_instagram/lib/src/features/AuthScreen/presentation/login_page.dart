import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_instagram/src/routing/route_constants.dart';
import 'package:my_instagram/src/ui_utils/app_snack_bar.dart';
import 'package:my_instagram/src/ui_utils/loading_screen.dart';
import '../../../ui_utils/divider_margins.dart';
import '../../../utils/src/constants.dart';
import '../../../utils/utils.dart';
import '../Provider/auth_provider.dart';
import '../Utils/auth_enums.dart';
import 'Widgets/face_book_button.dart';
import 'Widgets/google_button.dart';
import 'Widgets/login_view_sign_up_links.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.appName,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(Strings.welcomeToAppName,
                  style: Theme.of(context).textTheme.displaySmall),
              Text(
                Strings.logIntoYourAccount,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(height: 1.5),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () async {
                  await ref
                      .read(authStateProvider.notifier)
                      .loginwithFacebook();
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.loginButtonColor,
                  foregroundColor: AppColors.loginButtonTextColor,
                ),
                child: const FacebookButton(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () async {
                  final success = await ref
                      .read(authStateProvider.notifier)
                      .loginWithGoogle();
                  if (success == AuthResult.success) {
                    LoadingScreen.instance().hide();
                    if (context.mounted) {
                      Navigator.pushNamed(context, RouteConstants.homeScreen);
                    }
                  } else {
                    if (context.mounted) {
                      const AppSnackBar(message: "Failed To Login")
                          .showAppSnackBar(context);
                    }
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.loginButtonColor,
                  foregroundColor: AppColors.loginButtonTextColor,
                ),
                child: const GoogleButton(),
              ),
              const DividerWithMargin(),
              const LoginViewSignUpLink(),
            ],
          ),
        ),
      ),
    );
  }
}
