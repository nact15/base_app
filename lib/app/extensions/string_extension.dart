part of extensions;

extension StringExtension on String {
  String get capitalizeFirst {
    if (length >= 1) return this[0].toUpperCase() + substring(1);

    return this;
  }

  String get removeHtml {
    return Bidi.stripHtmlIfNeeded(this);
  }
}
