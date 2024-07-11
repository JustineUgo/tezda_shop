// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tezda_shop/theme/theme.dart';
import 'package:tezda_shop/util/assets.dart';

@RoutePage()
class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      backgroundColor: EcoColors.secondary,
      routes: const [
        // HomeRoute(),
        // BookingRoute(),
        // ProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: EcoColors.primary,
          unselectedItemColor: EcoColors.neutral,
          showSelectedLabels: false,
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
                label: '',
                icon: Column(
                  children: [
                    SvgPicture.asset(EcoIcons.home, color: tabsRouter.activeIndex == 0 ? EcoColors.primary : EcoColors.neutral),
                    Text('Home',
                        style: context.textTheme.bodySmall!.copyWith(fontSize: 12, color: tabsRouter.activeIndex == 0 ? EcoColors.primary : EcoColors.neutral))
                  ],
                )),
            BottomNavigationBarItem(
                label: '',
                icon: Column(
                  children: [
                    SvgPicture.asset(EcoIcons.bookmarks, color: tabsRouter.activeIndex == 1 ? EcoColors.primary : EcoColors.neutral),
                    Text('Bookmarks',
                        style: context.textTheme.bodySmall!.copyWith(fontSize: 12, color: tabsRouter.activeIndex == 1 ? EcoColors.primary : EcoColors.neutral))
                  ],
                )),
            BottomNavigationBarItem(
                label: '',
                icon: Column(
                  children: [
                    SvgPicture.asset(EcoIcons.profile, color: tabsRouter.activeIndex == 3 ? EcoColors.primary : EcoColors.neutral),
                    Text('Profile',
                        style: context.textTheme.bodySmall!.copyWith(fontSize: 12, color: tabsRouter.activeIndex == 3 ? EcoColors.primary : EcoColors.neutral)),
                  ],
                )),
          ],
        );
      },
    );
  }
}
