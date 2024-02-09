part of base_app_part;

final appRouter = AppRouter();

class BaseApp extends StatelessWidget {
  const BaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      child: MaterialApp.router(
        routerConfig: appRouter.config(
          navigatorObservers: () => [HeroController()],
        ),
        locale: const Locale.fromSubtags(languageCode: AppConstants.locale),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        title: AppConstants.titleApp,
        theme: AppTheme.mainTheme,
      ),
    );
  }
}
