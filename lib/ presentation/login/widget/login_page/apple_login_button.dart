import 'dart:io';

import 'package:app_55hz/%20presentation/login/provider/auth/agree/is_agree_provider.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/apple/apple_login_provider.dart';
import 'package:app_55hz/router/enum/router_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/sign_button.dart';

class AppleLoginButton extends ConsumerWidget {
  const AppleLoginButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(appleLoginProvider, (previous, next) {
      next.when(
        data: (_) {},
        error: (e, _) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.toString())));
        },
        loading: () {},
      );
    });
    final agreeToTerms = ref.watch(isAgreeProvider);
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(left: 50.0),
            child: SignInButton.mini(
                buttonType: ButtonType.appleDark,
                onPressed: agreeToTerms == false
                    ? null
                    : () async {
                        final notifier = ref.read(appleLoginProvider.notifier);
                        await notifier.appleLogin().catchError((e) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(e)));
                        }).then((result) {
                          if (result != null) {
                            context.go(RouteConfig.top.path);
                          }
                        });
                      }),
          )
        : const SizedBox.shrink();
  }
}
