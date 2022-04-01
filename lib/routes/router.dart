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
    AutoRoute(
      path: "/home",
      page: HomeWrapperPage,
      children: [
        AutoRoute(path: 'dashboard', page: DashboardPage),
        AutoRoute(path: 'profile', page: ProfilePage)
      ],
    ),
    AutoRoute(path: 'qr', page: QRScanPage),
    AutoRoute(path: 'products', page: ProductListPage),
  ],
)
class $AppRouter {}
