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
    HomeWrapperRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomeWrapperPage());
    },
    ProductListRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.ProductListPage());
    },
    DashboardRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i1.DashboardPage(),
          opaque: true,
          barrierDismissible: false);
    },
    QRScanRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.QRScanPage());
    },
    ProfileRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.ProfilePage());
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(AppViewRoute.name, path: '/'),
        _i2.RouteConfig(SplashRoute.name, path: '/splash'),
        _i2.RouteConfig(OnboardingRoute.name, path: '/onboarding'),
        _i2.RouteConfig(AuthFormRoute.name, path: '/auth'),
        _i2.RouteConfig(PINInputRoute.name, path: '/pin'),
        _i2.RouteConfig(HomeWrapperRoute.name, path: '/home', children: [
          _i2.RouteConfig(DashboardRoute.name,
              path: 'dashboard', parent: HomeWrapperRoute.name),
          _i2.RouteConfig(QRScanRoute.name,
              path: 'qr', parent: HomeWrapperRoute.name),
          _i2.RouteConfig(ProfileRoute.name,
              path: 'profile', parent: HomeWrapperRoute.name)
        ]),
        _i2.RouteConfig(ProductListRoute.name, path: 'products')
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
/// [_i1.HomeWrapperPage]
class HomeWrapperRoute extends _i2.PageRouteInfo<void> {
  const HomeWrapperRoute({List<_i2.PageRouteInfo>? children})
      : super(HomeWrapperRoute.name, path: '/home', initialChildren: children);

  static const String name = 'HomeWrapperRoute';
}

/// generated route for
/// [_i1.ProductListPage]
class ProductListRoute extends _i2.PageRouteInfo<void> {
  const ProductListRoute() : super(ProductListRoute.name, path: 'products');

  static const String name = 'ProductListRoute';
}

/// generated route for
/// [_i1.DashboardPage]
class DashboardRoute extends _i2.PageRouteInfo<void> {
  const DashboardRoute() : super(DashboardRoute.name, path: 'dashboard');

  static const String name = 'DashboardRoute';
}

/// generated route for
/// [_i1.QRScanPage]
class QRScanRoute extends _i2.PageRouteInfo<void> {
  const QRScanRoute() : super(QRScanRoute.name, path: 'qr');

  static const String name = 'QRScanRoute';
}

/// generated route for
/// [_i1.ProfilePage]
class ProfileRoute extends _i2.PageRouteInfo<void> {
  const ProfileRoute() : super(ProfileRoute.name, path: 'profile');

  static const String name = 'ProfileRoute';
}
