import 'package:flutter/material.dart';
import 'package:pcore/pcore.dart';
import 'package:ppub_dev/flutter_test.dart';
import 'package:ppub_dev/test_beautifier.dart';

MaterialApp localizedApp({required Widget Function(BuildContext) builder}) {
  return MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: const [PCoreL10n.delegate],
    home: Builder(builder: builder),
  );
}

void main() {
  group('PCoreL10n tests', () {
    testWidgets(
      requirement(
        Given: 'An app with PCoreL10n delegate',
        When: 'fetching PCoreL10n from BuildContext',
        Then: 'returns PCoreL10n instance',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizedApp(
            builder: (context) {
              expect(context.pCoreL10n, isNotNull);
              return Container();
            },
          ),
        );
      }),
    );
  });

  group('PL10nDateExtension tests', () {
    late String translation;

    testWidgets(
      requirement(
        Given: 'An app with PCoreL10n delegate and en locale',
        When: 'localizing a DateTime instance as yearMonthNumDayNum',
        Then: 'returns a localized string',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizedApp(
            builder: (context) {
              translation = DateTime(2024, 2, 10).pLocalize(context);
              return Container();
            },
          ),
        );

        expect(translation, '2/10/2024');
      }),
    );
    testWidgets(
      requirement(
        Given: 'An app with PCoreL10n delegate and en locale',
        When: 'localizing a DateTime instance as yearMonth',
        Then: 'returns a localized string',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizedApp(
            builder: (context) {
              translation = DateTime(2024, 2, 10).pLocalize(
                context,
                dateFormat: PDateFormat.yearMonth,
              );

              return Container();
            },
          ),
        );

        expect(translation, 'February 2024');
      }),
    );
  });

  group('PL10nNumExtension tests', () {
    late String translation;

    testWidgets(
      requirement(
        Given: 'An app with PCoreL10n delegate and en locale',
        When: 'localizing a num instance with 2 digits',
        Then: 'returns a localized string',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizedApp(
            builder: (context) {
              translation = 2.0399.pLocalize(context, decimalDigits: 2);
              return Container();
            },
          ),
        );

        expect(translation, '2.04');
      }),
    );
  });

  group('PL10nStringExtension tests', () {
    num? result;

    testWidgets(
      requirement(
        Given: 'An app with PCoreL10n delegate and en locale',
        When: 'turning localized string into num',
        Then: 'returns num with correct value',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizedApp(
            builder: (context) {
              result = '2.0399'.pToLocalizedNum(context);
              return Container();
            },
          ),
        );

        expect(result, 2.0399);
      }),
    );

    testWidgets(
      requirement(
        Given: 'An app with PCoreL10n delegate and en locale',
        When: 'turning badly formatted localized string into num',
        Then: 'returns null',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizedApp(
            builder: (context) {
              result = 'fsddjlsf'.pToLocalizedNum(context);
              return Container();
            },
          ),
        );

        expect(result, null);
      }),
    );
  });
}
