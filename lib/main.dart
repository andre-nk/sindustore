import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindu_store/app/auth/bloc/app_bloc.dart';

import 'package:sindu_store/app/bloc_observer.dart';
import 'package:sindu_store/config/theme.dart';
import 'package:sindu_store/repository/auth/auth_repository.dart';
import 'package:sindu_store/routes/router.gr.dart';

Future<void> main() async {
  return BlocOverrides.runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    //Repositories
    final authRepository = AuthRepository();

    //Router
    final _appRouter = AppRouter();

    //App Runner
    runApp(App(
      authRepository: authRepository,
      appRouter: _appRouter,
    ));
  }, blocObserver: AppBlocObserver());
}

class App extends StatelessWidget {
  final AuthRepository _authRepository;
  final AppRouter _appRouter;

  const App(
      {Key? key, required AuthRepository authRepository, required AppRouter appRouter})
      : _authRepository = authRepository,
        _appRouter = appRouter,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AppBloc(authRepository: _authRepository))
        ],
        child: AppView(appRouter: _appRouter),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  final AppRouter _appRouter;

  const AppView({Key? key, required AppRouter appRouter})
      : _appRouter = appRouter,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme.appTheme(),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
