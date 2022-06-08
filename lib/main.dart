import 'dart:async';
import 'package:flutter/foundation.dart' show kDebugMode;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindu_store/app/auth/bloc/auth_bloc.dart';
import 'package:sindu_store/app/bloc_observer.dart';

import 'package:sindu_store/config/theme.dart';
import 'package:sindu_store/view/screens/screens.dart';
import 'package:sindu_store/repository/auth/auth_repository.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) async {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppTheme.colors.primary),
      );

      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

      if (kDebugMode) {
        await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
      } else {
      }

      BlocOverrides.runZoned(
        () => runApp(const App()),
        blocObserver: AppBlocObserver(),
      );
    });
  }, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme.appTheme(),
      title: 'SinduStore',
      home: BlocProvider(
        create: (_) => AuthBloc(AuthRepository()),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const HomeWrapperPage();
        } else if (state is AuthStateLoggedIn && !state.isPINCorrect ||
            state is AuthStatePINChanged) {
          return const PINInputPage();
        } else if (state is AuthStateLoggedOut) {
          return const OnboardingPage();
        } else if (state is AuthStateInitial) {
          return const SplashPage();
        } else {
          return const SplashPage();
        }
      },
    );
  }
}
