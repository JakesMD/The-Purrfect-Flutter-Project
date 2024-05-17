import 'package:flutter/material.dart';
import 'package:pcore/pcore.dart';
import 'package:ppub_dev/flutter_test.dart';
import 'package:ppub_dev/test_beautifier.dart';

Widget localizations({required Widget Function(BuildContext context) builder}) {
  return Localizations(
    delegates: PCoreL10n.localizationsDelegates,
    locale: PCoreL10n.supportedLocales[0],
    child: Builder(builder: builder),
  );
}

void main() {
  group('PTextInput Tests', () {
    late PTextInput input;
    String? result;

    setUp(() => input = PTextInput());

    testWidgets(
      requirement(
        Given: 'empty input',
        When: 'validate',
        Then: 'returns string',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizations(
            builder: (context) {
              result = input.validator(input: ' ', context: context);
              return Container();
            },
          ),
        );
        expect(result, isNotNull);
      }),
    );

    testWidgets(
      requirement(
        Given: 'valid input',
        When: 'parse',
        Then: 'returns username',
      ),
      widgetsProcedure((tester) async {
        await tester.pumpWidget(
          localizations(
            builder: (context) {
              result = input.parse(input: 'abc', context: context);
              return Container();
            },
          ),
        );
        expect(result, 'abc');
      }),
    );
  });
}
