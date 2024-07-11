import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tezda_shop/src/screens/app/profile/widgets/profile_tile_widget.dart';
import 'package:tezda_shop/theme/theme.dart';
import 'package:tezda_shop/util/assets.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Update your name!', style: context.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400, fontSize: 20)),
                      const SizedBox(height: 10),
                      Text('tezda@gmail.com', style: context.textTheme.headlineLarge!.copyWith(fontSize: 18)),
                      Text('+998931256532', style: context.textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w400)),
                    ],
                  ),
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
                      const ProfileTile(text: 'Personal Information', icon: TezdaIcons.personalInfoIcon, trailing: Icon(CupertinoIcons.right_chevron)),
                      const ProfileTile(text: 'Version', icon: TezdaIcons.infoIcon, trailing: Text('Version 1.0')),
                      const ProfileTile(text: 'Logout', icon: TezdaIcons.logoutIcon, color: TezdaColors.destructiveAccent),
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
