part of "../screens.dart";  

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Log out", style: AppTheme.text.paragraph.copyWith(color: Colors.white),),
          onPressed: () {
            context.read<AuthBloc>().add(AuthEventSignOut());
          },
        )
      ) 
    );
  }
}