import 'package:auto_route/auto_route.dart';
import 'package:untitled/app/ui/home/home_part.dart';
import 'package:untitled/app/ui/splash/splash_part.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: HomeRoute.page,
        ),
      ];
}

class EmptyRouterScreen extends AutoRouter {
  const EmptyRouterScreen({super.key});
}
