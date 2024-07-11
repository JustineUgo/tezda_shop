// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tezda_shop/routes/router.gr.dart';
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
      backgroundColor: TezdaColors.secondary,
      routes: const [
        HomeRoute(),
        BookmarkRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: TezdaColors.primary,
          unselectedItemColor: TezdaColors.neutral,
          showSelectedLabels: false,
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
                label: '',
                icon: Column(
                  children: [
                    SvgPicture.asset(TezdaIcons.home, color: tabsRouter.activeIndex == 0 ? TezdaColors.primary : TezdaColors.neutral),
                    Text('Home',
                        style:
                            context.textTheme.bodySmall!.copyWith(fontSize: 12, color: tabsRouter.activeIndex == 0 ? TezdaColors.primary : TezdaColors.neutral))
                  ],
                )),
            BottomNavigationBarItem(
                label: '',
                icon: Column(
                  children: [
                    SvgPicture.asset(TezdaIcons.bookmarks, color: tabsRouter.activeIndex == 1 ? TezdaColors.primary : TezdaColors.neutral),
                    Text('Bookmarks',
                        style:
                            context.textTheme.bodySmall!.copyWith(fontSize: 12, color: tabsRouter.activeIndex == 1 ? TezdaColors.primary : TezdaColors.neutral))
                  ],
                )),
            BottomNavigationBarItem(
                label: '',
                icon: Column(
                  children: [
                    SvgPicture.asset(TezdaIcons.profile, color: tabsRouter.activeIndex == 3 ? TezdaColors.primary : TezdaColors.neutral),
                    Text('Profile',
                        style: context.textTheme.bodySmall!
                            .copyWith(fontSize: 12, color: tabsRouter.activeIndex == 3 ? TezdaColors.primary : TezdaColors.neutral)),
                  ],
                )),
          ],
        );
      },
    );
  }
}
