part of "../screens.dart";

class InvoiceListPage extends StatelessWidget {
  const InvoiceListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InvoiceBloc(InvoiceRepository())
        ..add(
          InvoiceEventFetchActiveQuery(),
        ),
      child: Scaffold(
        appBar: GeneralAppBar(
          title: "Riwayat Nota (Hari Ini)",
          singleAction: Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: Theme(
              data: ThemeData(
                  textTheme: TextTheme(
                      bodyMedium: AppTheme.text.paragraph
                          .copyWith(color: AppTheme.colors.primary))),
              child: BlocBuilder<InvoiceBloc, InvoiceState>(
                builder: (context, state) {
                  return IconButton(
                    icon: const Icon(
                      Ionicons.calendar_outline,
                      size: 22,
                    ),
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData(
                              splashColor: Colors.black,
                              textTheme: const TextTheme(
                                subtitle1: TextStyle(color: Colors.black),
                                button: TextStyle(color: Colors.black),
                              ),
                              dialogBackgroundColor: Colors.white,
                              colorScheme: const ColorScheme.light(
                                primary: Color(0xffffbc00),
                                onSecondary: Colors.black,
                                onPrimary: Colors.white,
                                surface: Colors.black,
                                onSurface: Colors.black,
                                secondary: Colors.black,
                              ).copyWith(
                                primary: AppTheme.colors.primary,
                                secondary: Colors.black,
                              ),
                            ),
                            child: child ?? const Text(""),
                          );
                        },
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1990),
                        lastDate: DateTime(2100),
                      );

                      if (picked != null) {
                        context
                            .read<InvoiceBloc>()
                            .add(InvoiceEventFetchQueryByDate(picked));
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ),
        body: SizedBox(
          child: BlocBuilder<InvoiceBloc, InvoiceState>(
            builder: (context, state) {
              if (state is InvoiceStateQueryLoaded) {
                return FirestoreQueryBuilder(
                  pageSize: 5,
                  query: state.query,
                  builder: (context, snapshot, _) {
                    if (snapshot.docs.isEmpty) {
                      return Center(
                        child: SizedBox(
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
                                  padding: const EdgeInsets.only(top: 36.0, bottom: 8.0),
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
                        ),
                      );
                    } else {
                      snapshot.docs.forEach((element) {
                        print(element.data());
                      });

                      return SizedBox();
                    }
                  },
                );
              } else if (state is InvoiceStateQueryFetching) {
                return const CustomLoadingIndicator();
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
