class Optional<T> {
  T? value;
  bool? assigned;

  Optional([T? value]) {
    if (value != null) {
      this.value = value;
      assigned = true;
    } else {
      this.value = null;
      assigned = false;
    }
  }

  bool hasValue() {
    return assigned ?? false;
  }

  T getValue() {
    if (!(assigned ?? false)) throw Exception();
    return value as T;
  }
}