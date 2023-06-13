import 'package:my_instagram/src/features/AuthScreen/presentation/login_page.dart';
import 'package:my_instagram/src/features/home/create_new_post_view.dart';
import 'package:my_instagram/src/features/home/home.dart';
import 'package:my_instagram/src/features/postDetail/presentaion/post_details_screen.dart';
import 'package:my_instagram/src/features/postDetail/presentaion/widgets/post_comments_view.dart';

import '../../src/routing/route_constants.dart';
import 'package:flutter/material.dart';

import '../features/splash/screen/splash_screen.dart';

class RouteManager {
  MaterialPageRoute<dynamic> route(RouteSettings settings) {
    dynamic data = settings.arguments != null ? settings.arguments ?? {} : {};

    switch (settings.name) {
      case RouteConstants.splashScreen:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteConstants.splashScreen),
            builder: (context) => const SplashScreen());
      case RouteConstants.loginScreen:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteConstants.loginScreen),
            builder: (context) => const LoginScreen());
      case RouteConstants.homeScreen:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteConstants.homeScreen),
            builder: (context) => const HomeScreen());
      case RouteConstants.postDetail:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteConstants.postDetail),
            builder: (context) => PostDetailsView(
                  post: data['post'],
                ));
      case RouteConstants.createPost:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteConstants.createPost),
            builder: (context) => CreateNewPostView(
                fileToPost: data['fileToPost'], fileType: data['fileType']));
      case RouteConstants.postComment:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteConstants.postComment),
            builder: (context) => PostCommentsView(postId: data['postId']));
      default:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteConstants.splashScreen),
            builder: (context) => const SplashScreen());
    }
  }
}

RouteFactory get onGenerateRoute => RouteManager().route;
