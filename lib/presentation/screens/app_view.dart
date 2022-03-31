part of "./screens.dart";

class AppViewPage extends StatelessWidget {
  const AppViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      listenWhen: ((previous, current) {
        return previous.status != current.status;
      }),
      listener: (context, state) {
        switch (state.status) {
          case AppStatus.authenticated:
            context.router.replace(const PINInputRoute());
            break;
          case AppStatus.unauthenticated:
            context.router.replace(const OnboardingRoute());
            break;
          case AppStatus.initial:
            context.router.replace(const SplashRoute());
            break;
          default:
            context.router.replace(const SplashRoute());
            break;
        }
      },
      child: const SplashPage(),
    );
  }
}
