// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$PAppRouter extends RootStackRouter {
  // ignore: unused_element
  _$PAppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    PHomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PHomePage(),
      );
    }
  };
}

/// generated route for
/// [PHomePage]
class PHomeRoute extends PageRouteInfo<void> {
  const PHomeRoute({List<PageRouteInfo>? children})
      : super(
          PHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'PHomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
