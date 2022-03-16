part of "../screens.dart";

class AuthFormPage extends StatelessWidget {
  const AuthFormPage({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute(builder: (_) => const AuthFormPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Center(
        child: Text("Woi"),
      ),
    );
  }
}
