import 'package:flutter/material.dart';
import 'package:ppub_dev/flutter_test.dart';
import 'package:ppub_dev/test_beautifier.dart';
import 'package:purrfect/app/app.dart';
import 'package:purrfect/pages/_pages.dart';

void main() {
  group('PurrfectApp tests', () {
    testWidgets(
      requirement(
        Given: 'Flavor is development',
        When: 'PurrfectApp is built',
        Then: 'MaterialBanner is not displayed',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(PurrfectApp(flavor: PAppFlavor.development));
        expect(find.byType(MaterialBanner), findsNothing);
      }),
    );

    testWidgets(
      requirement(
        Given: 'Flavor is staging',
        When: 'PurrfectApp is built',
        Then: 'PStagingBanner is displayed',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(PurrfectApp(flavor: PAppFlavor.staging));
        expect(find.byType(MaterialBanner), findsOneWidget);
      }),
    );

    testWidgets(
      requirement(
        Given: 'Flavor is production',
        When: 'PurrfectApp is built',
        Then: 'PStagingBanner is not displayed',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(PurrfectApp(flavor: PAppFlavor.development));
        expect(find.byType(MaterialBanner), findsNothing);
      }),
    );

    testWidgets(
      requirement(
        When: 'PurrfectApp is first built',
        Then: 'Home page is displayed',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(PurrfectApp(flavor: PAppFlavor.development));
        expect(find.byType(PHomePage), findsNothing);
      }),
    );
  });
}
