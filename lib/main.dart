import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindu_store/app/auth/bloc/app_bloc.dart';

import 'package:sindu_store/app/bloc_observer.dart';
import 'package:sindu_store/config/theme.dart';
import 'package:sindu_store/view/screens/screens.dart';
import 'package:sindu_store/repository/auth/auth_repository.dart';

Future<void> main() async {
  return BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    //App Runner
    runApp(const App());
  }, blocObserver: AppBlocObserver());
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
        create: (_) => AppBloc(AuthRepository()),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AppBloc>().add(const AppEventInitialize());

    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is AppStateLoggedIn && state.isPINCorrect) {
          return const HomeWrapperPage();
        } else if (state is AppStateLoggedIn && !state.isPINCorrect){
          return const PINInputPage();
        } else if (state is AppStateLoggedOut) {
          return const OnboardingPage();
        } else if (state is AppStateInitial) {
          return const SplashPage();
        } else {
          return const SplashPage();
        }
      },
    );
  }
}
