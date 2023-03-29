// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/cupertino.dart' as _i4;
import 'package:flutter/material.dart' as _i3;

import '../../data/models/record_response_model.dart' as _i5;
import '../ui/screens.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    LoginRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginPage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    NoInternetRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.NoInternetPage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    HomeRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    ProfileRoute.name: (routeData) {
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: const _i1.ProfilePage(),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
    DetailRoute.name: (routeData) {
      final args = routeData.argsAs<DetailRouteArgs>();
      return _i2.CustomPage<dynamic>(
        routeData: routeData,
        child: _i1.DetailPage(
          key: args.key,
          data: args.data,
          list: args.list,
        ),
        transitionsBuilder: _i2.TransitionsBuilders.fadeIn,
        opaque: true,
        barrierDismissible: false,
      );
    },
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/splash',
          fullMatch: true,
        ),
        _i2.RouteConfig(
          SplashRoute.name,
          path: '/splash',
        ),
        _i2.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i2.RouteConfig(
          NoInternetRoute.name,
          path: '/error',
        ),
        _i2.RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
        _i2.RouteConfig(
          ProfileRoute.name,
          path: '/profile',
        ),
        _i2.RouteConfig(
          DetailRoute.name,
          path: '/detail',
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i2.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/splash',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i1.LoginPage]
class LoginRoute extends _i2.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i1.NoInternetPage]
class NoInternetRoute extends _i2.PageRouteInfo<void> {
  const NoInternetRoute()
      : super(
          NoInternetRoute.name,
          path: '/error',
        );

  static const String name = 'NoInternetRoute';
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i2.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i1.ProfilePage]
class ProfileRoute extends _i2.PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: '/profile',
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i1.DetailPage]
class DetailRoute extends _i2.PageRouteInfo<DetailRouteArgs> {
  DetailRoute({
    _i4.Key? key,
    required _i5.MeterData data,
    required List<_i5.MeterData> list,
  }) : super(
          DetailRoute.name,
          path: '/detail',
          args: DetailRouteArgs(
            key: key,
            data: data,
            list: list,
          ),
        );

  static const String name = 'DetailRoute';
}

class DetailRouteArgs {
  const DetailRouteArgs({
    this.key,
    required this.data,
    required this.list,
  });

  final _i4.Key? key;

  final _i5.MeterData data;

  final List<_i5.MeterData> list;

  @override
  String toString() {
    return 'DetailRouteArgs{key: $key, data: $data, list: $list}';
  }
}
