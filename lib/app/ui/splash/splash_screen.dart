part of splash;

@RoutePage()
class SplashScreen extends StatefulWidget implements AutoRouteWrapper {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc(splashUseCase: injection())..add(SplashStart()),
      child: this,
    );
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      topSafe: false,
      bottomSafe: false,
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state.splashStatus == SplashStatus.goToAuthorization) {
            // TODO: navigate to auth
            context.replace(const HomeRoute());
          }
          if (state.splashStatus == SplashStatus.goToHome) {
            context.replace(const HomeRoute());
          }
        },
        child: const Center(
          child: BaseLoader(color: AppColors.primary),
        ),
      ),
    );
  }
}
