part of "../screens.dart";

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: DashboardPage());

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppTheme.colors.primary),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            InvoiceBloc(InvoiceRepository())..add(InvoiceEventFetchQuery()),
        child: BlocBuilder<InvoiceBloc, InvoiceState>(
          builder: (context, state) {
            if (state is InvoiceStateQueryFetching) {
              return const LoadingIndicator();
            } else if (state is InvoiceStateQueryLoaded) {
              return FirestoreQueryBuilder(
                pageSize: 5,
                query: state.query,
                builder: (context, snapshot, _) {
                  if (snapshot.docs.isEmpty) {
                    return Stack(
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: MQuery.width(0.05, context),
                            vertical: MQuery.height(0.105, context),
                          ),
                          child: Column(
                            children: [
                              const MainBox(),
                              SizedBox(
                                height: MQuery.height(0.5, context),
                                width: MQuery.width(0.75, context),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/404_illustration.png",
                                        height: MQuery.height(0.125, context),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 36.0, bottom: 8.0),
                                        child: Text(
                                          "Tidak ada nota aktif!",
                                          style: AppTheme.text.h3,
                                        ),
                                      ),
                                      Text(
                                        "Coba buat nota di atas",
                                        style: AppTheme.text.subtitle,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return DashboardInvoiceList(snapshot: snapshot);
                  }
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
