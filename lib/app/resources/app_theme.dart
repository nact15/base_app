part of resources;

class AppTheme {
  static final ThemeData mainTheme = ThemeData(
    primaryColor: AppColors.primary,
    brightness: Brightness.light,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent
    ),
  );

  static SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.white,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarContrastEnforced: true,
    systemStatusBarContrastEnforced: false,
    statusBarIconBrightness: Brightness.light,
    statusBarColor: AppColors.white,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: AppColors.white,
  );

  static SystemUiOverlayStyle darkSystemUiOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.white,
    statusBarBrightness: Brightness.light,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarContrastEnforced: true,
    systemStatusBarContrastEnforced: false,
    statusBarIconBrightness: Brightness.light,
    statusBarColor: AppColors.white.withOpacity(0.0001),
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  AppTheme._();
}
