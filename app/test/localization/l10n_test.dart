import 'package:flutter/material.dart';
import 'package:ppub_dev/flutter_test.dart';
import 'package:ppub_dev/test_beautifier.dart';
import 'package:purrfect/localization/l10n.dart';

MaterialApp localizedApp({required Widget Function(BuildContext) builder}) {
  return MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: const [PAppL10n.delegate],
    home: Builder(builder: builder),
  );
}

void main() {
  group('PAppL10n tests', () {
    testWidgets(
      requirement(
        Given: 'An app with PAppL10n delegate',
        When: 'fetching PAppL10n from BuildContext',
        Then: 'returns PAppL10n instance',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizedApp(
            builder: (context) {
              expect(context.pAppL10n, isNotNull);
              return Container();
            },
          ),
        );
      }),
    );
  });
}
