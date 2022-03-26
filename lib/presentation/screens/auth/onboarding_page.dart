part of "../screens.dart";

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: OnboardingPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.colors.background,
        title: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/logo_wide.png",
                height: 24,
              ),
              IconButton(
                padding: EdgeInsets.zero,
                iconSize: 24,
                splashRadius: 24,
                onPressed: () {},
                icon: const Icon(
                  Ionicons.help_circle_outline,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MQuery.width(0.05, context),
        ),
        width: MQuery.width(1, context),
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MQuery.width(0.075, context),
              ),
              child: Image.asset(
                "assets/onboarding_illustration.png",
                height: MQuery.height(0.25, context),
              ),
            ),
            Column(
              children: [
                Text(
                  "Selamat datang!",
                  style: AppTheme.text.h2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: Text(
                    "SinduStore adalah aplikasi kasir dan manajemen stok pribadi untuk toko Sinar Dunia Elektrik",
                    textAlign: TextAlign.center,
                    style: AppTheme.text.paragraph.copyWith(height: 1.67),
                  ),
                ),
                SizedBox(
                  height: MQuery.height(0.065, context),
                ),
                WideButton(
                  title: "Masuk ke akun",
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: const AuthFormPage(),
                        childCurrent: this,
                        type: PageTransitionType.rightToLeftJoined,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Butuh bantuan? Hubungi admin",
                    textAlign: TextAlign.center,
                    style: AppTheme.text.subtitle.copyWith(height: 1.67),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
