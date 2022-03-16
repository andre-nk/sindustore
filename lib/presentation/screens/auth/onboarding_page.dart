part of "../screens.dart";

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: OnboardingPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
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
                    )),
              ],
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MQuery.width(context, 0.05)),
          width: MQuery.width(context, 1),
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MQuery.width(context, 0.075)),
                child: Image.asset("assets/onboarding_illustration.png",
                    height: MQuery.height(context, 0.25)),
              ),
              Column(
                children: [
                  Text(
                    "Selamat datang!",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Text(
                      "SinduStore adalah aplikasi kasir dan manajemen stok pribadi untuk toko Sinar Dunia Elektrik",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(height: 1.67),
                    ),
                  ),
                  SizedBox(
                    height: MQuery.height(context, 0.065),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(AuthFormPage.route());
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          minimumSize: const Size(double.infinity, 54)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Masuk ke akun",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                      )),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "Butuh bantuan? Hubungi admin",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(height: 1.67),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
