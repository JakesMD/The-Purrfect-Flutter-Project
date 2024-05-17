import 'package:ppub/auto_route.dart';
import 'package:purrfect/pages/_pages.dart';

part 'router.gr.dart';

/// The router for the app.
///
/// This class is responsible for defining the routes for the app.
@AutoRouterConfig(replaceInRouteName: 'Page|Tab,Route')
class PAppRouter extends _$PAppRouter implements AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    resolver.next();
  }

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: PHomeRoute.page,
          initial: true,
        ),
      ];
}
