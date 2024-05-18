import 'package:pcore/pcore.dart';
import 'package:ppub_dev/flutter_test.dart';
import 'package:ppub_dev/test_beautifier.dart';

void main() {
  group('PFormInput Tests', () {
    late PFormInput<dynamic> input;

    setUp(() => input = PFormInput());

    test(
      requirement(
        When: 'first initialized',
        Then: 'input is null',
      ),
      procedure(() => expect(input.input, isNull)),
    );

    test(
      requirement(
        Given: 'new input',
        When: 'onChanged',
        Then: 'input is new input',
      ),
      procedure(() {
        input.onChanged('new input');
        expect(input.input, 'new input');
      }),
    );
  });
}
