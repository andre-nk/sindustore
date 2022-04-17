import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindu_store/app/auth/bloc/app_bloc.dart';

import 'package:sindu_store/app/bloc_observer.dart';
import 'package:sindu_store/config/theme.dart';
import 'package:sindu_store/presentation/screens/screens.dart';
import 'package:sindu_store/repository/auth/auth_repository.dart';

Future<void> main() async {
  return BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    //Repositories
    final authRepository = AuthRepository();

    //App Runner
    runApp(App(
      authRepository: authRepository,
    ));
  }, blocObserver: AppBlocObserver());
}

class App extends StatelessWidget {
  final AuthRepository _authRepository;

  const App({Key? key, required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AppBloc(authRepository: _authRepository))
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme.appTheme(),
      title: 'SinduStore',
      home: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if(state.status == AppStatus.authenticated){
            return const HomeWrapperPage();
          } else if (state.status == AppStatus.unauthenticated){
            return const OnboardingPage();
          } else if (state.status == AppStatus.initial){
            return const SplashPage();
          } else {
            return const SplashPage();
          }
        },
      ),
    );
  }
}
