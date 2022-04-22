part of "../screens.dart";  

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Log out"),
          onPressed: () async {

          },
        )
      ) 
    );
  }
}