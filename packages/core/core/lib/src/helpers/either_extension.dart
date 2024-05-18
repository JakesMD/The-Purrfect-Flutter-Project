import 'package:ppub/dartz.dart';

/// Provides extension methods for the [Either] type from dartz.
extension PEitherExtension<L, R> on Either<L, R> {
  /// Returns the right value brute forcefully.
  ///
  /// Will fail if not checked with `isRight()` or `!isLeft()` beforehand.
  R pAsRight() => (this as Right<L, R>).value;

  /// Returns the left value brute forcefully.
  ///
  /// Will fail if not checked with `isLeft()` or `!isRight()` beforehand.
  L pAsLeft() => (this as Left<L, R>).value;
}
