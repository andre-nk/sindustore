part of "../screens.dart";

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: DashboardPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.router.push(
              const ProductListRoute(),
            );
          },
          child: Text(
            "Woi, ini Home",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
