import 'package:ppub/flutter_web_plugins.dart';

/// Sets the URL strategy for web apps.
///
/// This is separated into `mobile_url_strategy.dart` and
/// `web_url_strategy.dart` so that either can be imported without platform
/// specific errors.
void pConfigureURLStrategy() => usePathUrlStrategy();
