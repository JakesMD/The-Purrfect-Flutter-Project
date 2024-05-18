import 'package:flutter/widgets.dart';
import 'package:ppub_dev/flutter_test.dart';
import 'package:ppub_dev/test_beautifier.dart';
import 'package:purrfect/shared/widgets/_widgets.dart';

class FakeBuildContext extends Fake implements BuildContext {}

// ignore: must_be_immutable
class TestWidget extends PSemiStatefulWidget {
  TestWidget({super.key});

  bool onInitCalled = false;
  bool buildCalled = false;
  bool onDisposeCalled = false;

  @override
  void onInit() {
    onInitCalled = true;
    super.onInit();
  }

  @override
  Widget build(BuildContext context) {
    buildCalled = true;
    return Container();
  }

  @override
  void onDispose() {
    onDisposeCalled = true;
    super.onDispose();
  }
}

void main() {
  group('PSemiStatefulWidget tests', () {
    testWidgets(
      requirement(
        Given: 'semi stateful widget',
        When: 'first build',
        Then: 'onInit is called',
      ),
      widgetsProcedure((tester) async {
        final testWidget = TestWidget();

        await tester.pumpWidget(testWidget);

        expect(testWidget.onInitCalled, true);
      }),
    );

    testWidgets(
      requirement(
        Given: 'semi stateful widget',
        When: 'built',
        Then: 'build is called',
      ),
      widgetsProcedure((tester) async {
        final testWidget = TestWidget();

        await tester.pumpWidget(testWidget);

        expect(testWidget.buildCalled, true);
      }),
    );

    testWidgets(
      requirement(
        Given: 'semi stateful widget',
        When: 'disposed',
        Then: 'onDispose is called',
      ),
      widgetsProcedure((tester) async {
        final testWidget = TestWidget();

        await tester.pumpWidget(testWidget);
        await tester.pumpWidget(Container());

        expect(testWidget.onDisposeCalled, true);
      }),
    );

    testWidgets(
      requirement(
        Given: 'semi stateful widget without build method',
        When: 'build',
        Then: 'throws UnimplementedError',
      ),
      widgetsProcedure((tester) async {
        expect(
          () => const PSemiStatefulWidget().build(FakeBuildContext()),
          throwsUnimplementedError,
        );
      }),
    );
  });
}
