part of "../screens.dart";

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Woi, ini Home",
          style: Theme.of(context).textTheme.displayLarge,
        )
      ) 
    );
  }
}
