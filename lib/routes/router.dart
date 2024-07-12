import 'package:auto_route/auto_route.dart';
import 'package:tezda_shop/injection/injection.dart';
import 'package:tezda_shop/routes/router.gr.dart';
import 'package:tezda_shop/src/repositories/auth_repo.dart';

@AutoRouterConfig()
class TezdaRouter extends $TezdaRouter implements AutoRouteGuard {
  @override
  List<AutoRoute> get routes => [
        RedirectRoute(path: '/', redirectTo: '/home'),
        AutoRoute(page: AuthRoute.page, path: '/auth'),
        AutoRoute(
          page: AppRoute.page,
          path: '/home',
          children: [
            AutoRoute(page: HomeRoute.page, path: ''),
            AutoRoute(page: WishlistRoute.page, path: 'bookmark'),
            AutoRoute(page: ProfileRoute.page, path: 'profile'),
          ],
        ),
        AutoRoute(page: ProductRoute.page, path: '/product'),
        AutoRoute(page: ProfileUpdateRoute.page, path: '/profile-update'),
        RedirectRoute(path: '*', redirectTo: '/'),
      ];

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    
    resolver;
    if (!getIt<AuthRepo>().isAuthenticated && resolver.route.fullPath == "/auth") {
      resolver.next(true);
      return;
    }
    if (getIt<AuthRepo>().isAuthenticated) {
      resolver.next(true);
    } else {
      resolver.redirect(const AuthRoute());
    }
  }
}
