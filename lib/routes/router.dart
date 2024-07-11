import 'package:auto_route/auto_route.dart';
import 'package:tezda_shop/routes/router.gr.dart';

@AutoRouterConfig()
class TezdaRouter extends $TezdaRouter implements AutoRouteGuard {
  @override
  List<AutoRoute> get routes => [
        RedirectRoute(path: '/', redirectTo: '/home'),
        AutoRoute(
          page: AppRoute.page,
          path: '/home',
          children: [
            AutoRoute(page: HomeRoute.page, path: ''),
            AutoRoute(page: WishlistRoute.page, path: 'bookmark'),
            AutoRoute(page: ProfileRoute.page, path: 'profile'),
          ],
        ),
        RedirectRoute(path: '*', redirectTo: '/'),
      ];

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    resolver.next(true);
  }
}
