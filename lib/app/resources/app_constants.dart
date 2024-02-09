part of resources;

const double kLeadingWidth = 40;

class AppConstants {
  AppConstants._();

  static const String titleApp = 'Base App';

  static final RegExp nameRegExp = RegExp(r'[a-zA-Z-\s]+$');

  static final RegExp spaceRegExp = RegExp(r'\s');

  static final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9._-]+\.[a-zA-Z]{2,}",
  );

  static const int timeRemaining = 60;

  static const Duration animationDuration = Duration(milliseconds: 350);

  static const double mapZoom = 18;

  static const String emptyString = '';

  static const String locale = 'RU';
}
