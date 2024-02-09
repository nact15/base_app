part of 'extensions.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;

  String get getCountryCode => Localizations.localeOf(this).languageCode;
}
