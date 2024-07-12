import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_shop/injection/injection.dart';
import 'package:tezda_shop/routes/router.gr.dart';
import 'package:tezda_shop/src/models/user/user_model.dart';
import 'package:tezda_shop/src/screens/app/home/provider/home_provider.dart';
import 'package:tezda_shop/src/screens/app/profile/provider/profile_provider.dart';
import 'package:tezda_shop/src/screens/app/profile/widgets/profile_tile_widget.dart';
import 'package:tezda_shop/src/services/storage_service.dart';
import 'package:tezda_shop/src/services/ui_service.dart';
import 'package:tezda_shop/theme/theme.dart';
import 'package:tezda_shop/util/assets.dart';

@RoutePage()
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profileInfoAsync = ref.watch(profileInfoProvider);
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: TezdaColors.grey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Align(alignment: Alignment.centerLeft, child: Text('Profile', style: context.textTheme.titleLarge)),
                SizedBox(
                  height: 200,
                  child: profileInfoAsync.when(
                    loading: () => const SizedBox.shrink(),
                    data: (user) {
                      print(user);
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(user.name, style: context.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400, fontSize: 22)),
                          const SizedBox(height: 5),
                          Text(user.email, style: context.textTheme.headlineLarge!.copyWith(fontSize: 18)),
                        ],
                      );
                    },
                    error: (error, stackTrace) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              ref.invalidate(profileInfoProvider);
                              ref.read(profileInfoProvider);
                            },
                            child: const Text('Retry'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //  switch (profileState) {
                  //   AsyncData(:ProfileInfoData user ) => ,
                  //   AsyncError() => ,
                  //   _ => const Text('loading'),
                  // },
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: TezdaColors.light,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('General', style: context.textTheme.headlineLarge),
                      const SizedBox(height: 20),
                      ProfileTile(
                        text: 'Personal Information',
                        icon: TezdaIcons.personalInfoIcon,
                        trailing: const Icon(CupertinoIcons.right_chevron),
                        onTap: () {},
                      ),
                      ProfileTile(
                        text: 'Version',
                        icon: TezdaIcons.infoIcon,
                        trailing: const Text('Version 1.0'),
                        onTap: () {},
                      ),
                      ProfileTile(
                        text: 'Logout',
                        icon: TezdaIcons.logoutIcon,
                        color: TezdaColors.destructiveAccent,
                        onTap: () => getIt<UIService>().showConfirmationDialog(
                          context,
                          icon: TezdaIcons.logoutIcon,
                          title: 'Do you want to log out?',
                          body: 'You can login again',
                          status: DialogStatus.warning,
                          cancelText: 'No, cancel',
                          onCancel: () {},
                          confirmText: 'Yes',
                          onConfirm: () {
                            getIt<StorageService>().cleanStorage();
                            context.router.replaceAll([const AuthRoute()]);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
