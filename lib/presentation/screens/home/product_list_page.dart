part of "../screens.dart";

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Woi, ini list",
          style: Theme.of(context).textTheme.displayLarge,
        )
      ) 
    );
  }
}