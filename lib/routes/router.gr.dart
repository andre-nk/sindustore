// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import '../presentation/screens/screens.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    AppViewRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.AppViewPage());
    },
    SplashRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashPage());
    },
    OnboardingRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.OnboardingPage());
    },
    AuthFormRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.AuthFormPage());
    },
    PINInputRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.PINInputPage());
    },
    HomeRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.HomePage(),
          transitionsBuilder: _i2.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(AppViewRoute.name, path: '/'),
        _i2.RouteConfig(SplashRoute.name, path: '/splash'),
        _i2.RouteConfig(OnboardingRoute.name, path: '/onboarding'),
        _i2.RouteConfig(AuthFormRoute.name, path: '/auth'),
        _i2.RouteConfig(PINInputRoute.name, path: '/pin'),
        _i2.RouteConfig(HomeRoute.name, path: '/home')
      ];
}

/// generated route for
/// [_i1.AppViewPage]
class AppViewRoute extends _i2.PageRouteInfo<void> {
  const AppViewRoute() : super(AppViewRoute.name, path: '/');

  static const String name = 'AppViewRoute';
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i2.PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/splash');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i1.OnboardingPage]
class OnboardingRoute extends _i2.PageRouteInfo<void> {
  const OnboardingRoute() : super(OnboardingRoute.name, path: '/onboarding');

  static const String name = 'OnboardingRoute';
}

/// generated route for
/// [_i1.AuthFormPage]
class AuthFormRoute extends _i2.PageRouteInfo<void> {
  const AuthFormRoute() : super(AuthFormRoute.name, path: '/auth');

  static const String name = 'AuthFormRoute';
}

/// generated route for
/// [_i1.PINInputPage]
class PINInputRoute extends _i2.PageRouteInfo<void> {
  const PINInputRoute() : super(PINInputRoute.name, path: '/pin');

  static const String name = 'PINInputRoute';
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i2.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/home');

  static const String name = 'HomeRoute';
}
