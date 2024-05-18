import 'package:pcore/pcore.dart';
import 'package:ppub/dartz.dart';
import 'package:ppub_dev/flutter_test.dart';
import 'package:ppub_dev/test_beautifier.dart';

void main() {
  group('PEitherExtension Tests', () {
    test(
      requirement(
        Given: 'Right with some value',
        When: 'pAsRight',
        Then: 'returns value',
      ),
      procedure(() => expect(right(12).pAsRight(), 12)),
    );

    test(
      requirement(
        Given: 'Left with some value',
        When: 'pAsLeft',
        Then: 'returns value',
      ),
      procedure(() => expect(left(32).pAsLeft(), 32)),
    );
  });
}
