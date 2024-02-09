part of extensions;

extension NumExtension on num {
  String get numberWithSign {
    final numSign = switch (sign) {
      1.0 => '+',
      -1.0 => '',
      (_) => '',
    };

    return numSign + toString();
  }
}
