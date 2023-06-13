// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_instagram/src/features/myposts/presentation/user_posts_view.dart';
import 'package:my_instagram/src/features/postDetail/providers/%20can_current_user_delete_post_provider.dart';
import 'package:my_instagram/src/routing/route_constants.dart';
import 'package:my_instagram/src/ui_utils/alert_dialog_model.dart';

import '../../ui_utils/app_snack_bar.dart';
import '../../ui_utils/image_picker_helper.dart';
import '../../ui_utils/loading_screen.dart';
import '../../utils/src/constants.dart';
import '../../utils/src/extensions/file_type.dart';
import '../AuthScreen/Provider/auth_provider.dart';
import '../searchScreen/presentaion/search_view.dart';
import 'home_view.dart';
import 'presentaion/widgets/logout_dialog.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // ref.listen(isLoadingProvider, (_, isLoading) {
    //   if (isLoading) {
    //     return LoadingScreen.instance().show(context: context);
    //   } else {
    //     return LoadingScreen.instance().hide();
    //   }
    // });
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          // leading: SizedBox(),
          title: const Text(
            Strings.appName,
          ),
          actions: [
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.film,
              ),
              onPressed: () async {
                final videoFile =
                    await ImagePickerHelper.pickVideoFromGallery();
                if (videoFile == null) {
                  return;
                }

                ref.refresh(postSettingProvider);
                // go to the screen to create a new post
                if (!mounted) {
                  return;
                }
                Navigator.pushNamed(context, RouteConstants.createPost,
                    arguments: {
                      "fileType": FileType.video,
                      "fileToPost": videoFile,
                    });
              },
            ),
            IconButton(
              onPressed: () async {
                final videoFile =
                    await ImagePickerHelper.pickImageFromGallery();
                if (videoFile == null) {
                  return;
                }

                ref.refresh(postSettingProvider);
                // go to the screen to create a new post
                if (!mounted) {
                  return;
                }
                Navigator.pushNamed(context, RouteConstants.createPost,
                    arguments: {
                      "fileType": FileType.image,
                      "fileToPost": videoFile,
                    });
              },
              icon: const Icon(
                Icons.add_photo_alternate_outlined,
              ),
            ),
            IconButton(
              onPressed: () async {
                final shouldLogOut = await LogoutDialog().present(context).then(
                      (value) => value ?? false,
                    );
                print(shouldLogOut);
                if (shouldLogOut) {
                  LoadingScreen.instance().show(context: context);

                  await ref.read(authStateProvider.notifier).logOut();

                  // if (ref.watch(authStateProvider).isLoading) {
                  LoadingScreen.instance().hide();
                  Future.delayed(Duration(seconds: 1), () {
                    AppSnackBar(message: "Succesfully logged out")
                        .showAppSnackBar(context);
                  });

                  Navigator.pushNamed(context, RouteConstants.loginScreen);
                  // } else {
                  // AppSnackBar(message: "Logout Failed")
                  //     .showAppSnackBar(context);
                  // }
                } else {
                  AppSnackBar(message: "Logout Failed")
                      .showAppSnackBar(context);
                }
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(
                  Icons.person,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.search,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.home,
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HomeView(),
            SearchView(),
            UserPostsView(),
          ],
        ),
      ),
    );
  }
}
