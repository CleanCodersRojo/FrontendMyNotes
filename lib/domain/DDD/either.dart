class Either<TLeft, TRight> {
  final value;
  final bool left;

  Either(this.value, this.left);

  bool isLeft() {
    return left;
  }

  TLeft getLeft() {
    if (!isLeft()) throw new Exception();
    return value as TLeft;
  }

  bool isRight() {
    return !left;
  }

  TRight getRight() {
    if (!isRight()) throw new Exception();
    return value as TRight;
  }

  static makeLeft<TLeft, TRight>(value) {
    return Either<TLeft, TRight>(value, true);
  }

  static makeRight<TLeft, TRight>(value) {
    return Either<TLeft, TRight>(value, false);
  }
}