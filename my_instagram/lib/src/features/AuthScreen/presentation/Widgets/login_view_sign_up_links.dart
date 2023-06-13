import 'package:flutter/material.dart';
import 'package:my_instagram/src/ui_utils/rich_text_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../ui_utils/base_text.dart';
import '../../../../utils/src/constants.dart';

class LoginViewSignUpLink extends StatelessWidget {
  const LoginViewSignUpLink({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      styleForAll: Theme.of(context).textTheme.titleSmall!.copyWith(
            height: 1.5,
          ),
      texts: [
        BaseText.plain(
          text: Strings.dontHaveAnAccount,
        ),
        BaseText.plain(
          text: Strings.signUpOn,
        ),
        BaseText.link(
            text: Strings.facebook,
            onTapped: () {
              launchUrl(Uri.parse(Strings.facebookSignupUrl));
            }),
        BaseText.plain(
          text: Strings.orCreateAnAccountOn,
        ),
        BaseText.link(
            text: Strings.google,
            onTapped: () {
              launchUrl(Uri.parse(Strings.googleSignupUrl));
            }),
      ],
    );
  }
}
