import 'package:auto_route/auto_route.dart';
import 'package:sindu_store/presentation/screens/screens.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: "/", page: AppViewPage, initial: true),
    AutoRoute(path: "/splash", page: SplashPage),
    AutoRoute(path: "/onboarding", page: OnboardingPage),
    AutoRoute(path: "/auth", page: AuthFormPage),
    AutoRoute(path: "/pin", page: PINInputPage),
    CustomRoute(path: "/home", page: HomePage, transitionsBuilder: TransitionsBuilders.slideLeft)
  ],
)
class $AppRouter {}
