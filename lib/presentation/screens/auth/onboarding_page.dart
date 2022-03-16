part of "../screens.dart";
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: OnboardingPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Selamat datang!",
          style: Theme.of(context).textTheme.headlineMedium,
        )
      )
    );
  }
}