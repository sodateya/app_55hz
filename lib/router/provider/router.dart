import 'dart:developer';

import 'package:app_55hz/%20presentation/account_delete/widget/account_delete_page.dart';
import 'package:app_55hz/%20presentation/add_post/widget/add_post_page.dart';
import 'package:app_55hz/%20presentation/add_talk/widget/add_talk_page.dart';
import 'package:app_55hz/%20presentation/ban_page/ban_page.dart';
import 'package:app_55hz/%20presentation/block/widget/block_list_page.dart';
import 'package:app_55hz/%20presentation/edit_profile/widget/edit_profile_page.dart';
import 'package:app_55hz/%20presentation/favorite/widget/favorite_page.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/crate_user/create_user_provider.dart';
import 'package:app_55hz/%20presentation/login/widget/email_check_page/email_check_page.dart';
import 'package:app_55hz/%20presentation/login/widget/forget_password/forget_password_page.dart';
import 'package:app_55hz/%20presentation/login/widget/login_page/login_page.dart';
import 'package:app_55hz/%20presentation/login/widget/signup_page/signup_page.dart';
import 'package:app_55hz/%20presentation/my_page/widget/my_page.dart';
import 'package:app_55hz/%20presentation/search/widget/search_page.dart';
import 'package:app_55hz/%20presentation/setting/widget/setting_page.dart';
import 'package:app_55hz/%20presentation/talk/widget/talk_page.dart';
import 'package:app_55hz/%20presentation/talk_to_admin/widget/talk_to_admin_page.dart';
import 'package:app_55hz/%20presentation/top/widget/top_page.dart';
import 'package:app_55hz/config/ban_list/is_ban_provider.dart';
import 'package:app_55hz/config/shared_prefarence/config_provider.dart';
import 'package:app_55hz/router/enum/router_config.dart';
import 'package:app_55hz/router/provider/is_block_db_provider.dart';
import 'package:app_55hz/router/provider/is_db_provider.dart';
import 'package:app_55hz/router/provider/is_favorite_db_provider.dart';
import 'package:app_55hz/router/provider/is_login_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
class Router extends _$Router {
  @override
  GoRouter build() {
    return GoRouter(
        navigatorKey: _rootNavigatorKey,
        redirect: (context, state) async {
          final isBan = await ref.read(isBanProvider.future);
          if (isBan) {
            return RouteConfig.banPage.path;
          }

          final isLogIn = ref.read(isLoginProvider);
          log('isLogin:${isLogIn.toString()}');
          if (!isLogIn) {
            if (state.fullPath!.length >= 6) {
              if (state.fullPath!.substring(0, 6) == RouteConfig.login.path) {
                return null;
              }
            }
            return RouteConfig.login.path;
          }
          final isEmailCheck = ref.read(isCheckMailVerifiedProvider);
          if (!isEmailCheck) {
            if (state.fullPath!.length >= 6) {
              if (state.fullPath!.substring(0, 6) == RouteConfig.login.path) {
                return null;
              }
            }
            log('isEmailCheck:${isEmailCheck.toString()}');

            return RouteConfig.login.path;
          }
          final isDb = await ref.read(isDbProvider.future);
          log('isDb:${isDb.toString()}');

          if (!isDb) {
            log('createDB');
            await ref.read(createUserProvider.notifier).createUserDb();
            final isBlockDb = await ref.read(isBlockDbProvider.future);
            if (!isBlockDb) {
              log('createBlock');
              await ref.read(createUserProvider.notifier).createBlockDb();
            }

            final isFavoriteDb = await ref.read(isFavoriteProvider.future);
            if (!isFavoriteDb) {
              log('createFavo');
              await ref.read(createUserProvider.notifier).createFavoriteDb();
            }
          }

          final isConfig = await ref.read(configProvider.notifier).getConfig();
          if (!isConfig) {
            await ref.read(configProvider.notifier).setConfig();
          }
          return null;
        },
        initialLocation: RouteConfig.top.path,
        errorBuilder: (context, state) => Scaffold(
              body: Center(
                child: Text('Error: ${state.error}'),
              ),
            ),
        routes: [
          GoRoute(
              path: RouteConfig.top.path,
              builder: (context, state) => const TopPage(),
              routes: [
                GoRoute(
                    path: '${RouteConfig.talk.path}/:postUid/:threadId/:postId',
                    builder: (context, state) {
                      final List extras = state.extra as List;
                      return TalkPage(
                          postUid: state.pathParameters['postUid']!,
                          postId: state.pathParameters['postId']!,
                          threadId: state.pathParameters['threadId']!,
                          title: extras[0] as String,
                          isUpdateToday: extras[1] as bool);
                    }),
                GoRoute(
                    path:
                        '${RouteConfig.addTalk.path}/:resNumber/:postId/:threadId',
                    builder: (context, state) {
                      return AddTalkPage(
                        resNumber: state.pathParameters['resNumber'],
                        postId: state.pathParameters['postId']!,
                        threadId: state.pathParameters['threadId']!,
                        isUpdateToday: state.extra as bool,
                      );
                    }),
                GoRoute(
                    path: '${RouteConfig.addPost.path}/:threadId/:threadTitle',
                    builder: (context, state) {
                      return AddPostPage(
                          threadId: state.pathParameters['threadId']!,
                          threadTitle: state.pathParameters['threadTitle']!);
                    }),
                GoRoute(
                  path: RouteConfig.myPage.path,
                  builder: (context, state) => const MyPage(),
                ),
                GoRoute(
                  path: RouteConfig.favoritePage.path,
                  builder: (context, state) => const FavoritePage(),
                ),
                GoRoute(
                  path: RouteConfig.settingPage.path,
                  builder: (context, state) => const SettingPage(),
                ),
                GoRoute(
                  path: RouteConfig.editProfilePage.path,
                  builder: (context, state) => const EditProfilePage(),
                ),
                GoRoute(
                  path: RouteConfig.blockListPage.path,
                  builder: (context, state) => const BlockListPage(),
                ),
                GoRoute(
                  path: RouteConfig.talkToAdminPage.path,
                  builder: (context, state) => const TalkToAdminPage(),
                ),
                GoRoute(
                  path: RouteConfig.accountDelete.path,
                  builder: (context, state) => const AccountDeletePage(),
                ),
                GoRoute(
                  path: RouteConfig.searchPage.path,
                  builder: (context, state) => SearchPage(
                    searchWord: state.extra as String,
                  ),
                ),
              ]),
          GoRoute(
              path: RouteConfig.login.path,
              builder: (context, state) => const LoginPage(),
              routes: [
                GoRoute(
                  path: RouteConfig.singUp.path,
                  builder: (context, state) => const SignUpPage(),
                ),
                GoRoute(
                  path: RouteConfig.forgetPassword.path,
                  builder: (context, state) => const ForgetPasswordPage(),
                ),
                GoRoute(
                  path: '${RouteConfig.emailCheckPage.path}/:email/:pass',
                  builder: (context, state) => EmailCheckPage(
                    email: state.pathParameters['email']!,
                    pass: state.pathParameters['pass']!,
                  ),
                ),
              ]),
          GoRoute(
            path: RouteConfig.banPage.path,
            builder: (context, state) => const BanPage(),
          ),
        ]);
  }
}
