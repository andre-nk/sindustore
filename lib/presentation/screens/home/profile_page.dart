part of "../screens.dart";  

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Woi, ini Profile",
          style: Theme.of(context).textTheme.displayLarge,
        )
      ) 
    );
  }
}