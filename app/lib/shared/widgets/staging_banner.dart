import 'package:flutter/material.dart';
import 'package:ppub/url_launcher.dart';
import 'package:purrfect/app/app_flavor.dart';
import 'package:purrfect/localization/l10n.dart';

/// {@template PStagingBanner}
///
/// A banner that is displayed when the app is in staging mode.
///
/// It warns the user that the app is in staging mode and provides a button to
/// open the production website.
///
/// {@endtemplate}
class PStagingBanner extends StatelessWidget {
  /// {@macro PStagingBanner}
  const PStagingBanner({
    required this.appFlavor,
    super.key,
  });

  /// The current app flavor.
  final PAppFlavor appFlavor;

  // coverage:ignore-start
  Future<void> _openProductionWebsite() async {
    await launchUrl(Uri.parse('https://google.com'));
  }
  // coverage:ignore-end

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: appFlavor == PAppFlavor.staging,
      child: MaterialBanner(
        leading: const Icon(Icons.construction_rounded),
        content: Text(context.pAppL10n.stagingBanner_message),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        actions: [
          TextButton(
            onPressed: _openProductionWebsite,
            child: Text(context.pAppL10n.stagingBanner_button),
          ),
        ],
      ),
    );
  }
}
