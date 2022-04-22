part of "../screens.dart";

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: DashboardPage());

  @override
  Widget build(BuildContext context) {

    print((context.read<AuthBloc>().state as AuthStateLoggedIn).user);

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: -1 * MQuery.width(1.005, context),
            child: Container(
              width: MQuery.width(1.5, context),
              height: MQuery.width(1.5, context),
              decoration: BoxDecoration(
                color: AppTheme.colors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 48,
            child: Image.asset("assets/logo_yellow.png", height: 48),
          ),
          ListView(
            padding: EdgeInsets.symmetric(
              horizontal: MQuery.width(0.05, context),
              vertical: MQuery.height(0.105, context),
            ),
            children: [
              Container(
                margin: const EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                  color: AppTheme.colors.background,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[900]!.withOpacity(0.075),
                      spreadRadius: 10,
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8, bottom: 4.0, left: 3, right: 4),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Icon(
                              Ionicons.search,
                              size: 20,
                              color: AppTheme.colors.primary,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: "Cari produk di toko...",
                          hintStyle: AppTheme.text.subtitle
                              .copyWith(color: AppTheme.colors.outline),
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: AppTheme.colors.outline.withOpacity(0.25),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Icon(Ionicons.cart_outline, size: 24),
                                ),
                                Text("Restock"),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Icon(Ionicons.receipt_outline, size: 24),
                                ),
                                Text("Buat Nota"),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Icon(Ionicons.time_outline, size: 24),
                                ),
                                Text("Riwayat"),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child:
                                      Icon(Ionicons.information_circle_outline, size: 24),
                                ),
                                Text("Informasi"),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 36.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nota aktif",
                      style: AppTheme.text.h3,
                    ),
                    Text(
                      "lihat semua",
                      style: AppTheme.text.subtitle.copyWith(color: AppTheme.colors.tertiary),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
