part of "../screens.dart";

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
      ),
      backgroundColor: AppTheme.colors.primary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 72.0),
          child: Image.asset(
            "assets/logo_yellow.png",
            height: MQuery.height(0.15, context),
          ),
        ),
      ),
    );
  }
}
