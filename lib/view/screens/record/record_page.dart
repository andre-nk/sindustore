part of "../screens.dart";

class ArchivePage extends StatefulWidget {
  const ArchivePage({Key? key}) : super(key: key);

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  DateTime? pickedDateTime;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SheetsBloc(SheetsRepository())
        ..add(
          SheetsEventFetchRecord(DateTime.now()),
        ),
      child: Scaffold(
        appBar: GeneralAppBar(
          title: pickedDateTime != null
              ? "Arsip Toko (${DateFormat.yMd().format(pickedDateTime!)})"
              : "Arsip Toko (Hari Ini)",
          singleAction: Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: Theme(
              data: ThemeData(
                textTheme: TextTheme(
                  bodyMedium:
                      AppTheme.text.paragraph.copyWith(color: AppTheme.colors.primary),
                ),
              ),
              child: BlocBuilder<SheetsBloc, SheetsState>(
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
                        initialDate: pickedDateTime ?? DateTime.now(),
                        firstDate: DateTime(1990),
                        lastDate: DateTime(2100),
                      );

                      if (picked != null) {
                        context.read<SheetsBloc>().add(
                              SheetsEventFetchRecord(picked),
                            );

                        setState(() {
                          pickedDateTime = picked;
                        });
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ),
        body: SizedBox(
          child: BlocBuilder<SheetsBloc, SheetsState>(
            builder: (context, state) {
              if (state is SheetsStateSuccess) {
                if (state.recordItems.isEmpty) {
                  return Center(
                    child: SizedBox(
                      height: MQuery.height(0.5, context),
                      width: MQuery.width(0.8, context),
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
                                "Belum ada riwayat penjualan!",
                                style: AppTheme.text.h3,
                              ),
                            ),
                            Text(
                              "Silahkan buat nota melalui Beranda",
                              style: AppTheme.text.subtitle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  final jsonRecordData =
                      state.recordItems.sublist(0, state.recordItems.length - 1);

                  List<Map> incompleteProducts = [];
                  for (var element
                      in state.recordItems.sublist(0, state.recordItems.length - 1)) {
                    if (element["Total Harga Beli"] == 0.0 ||
                        element["Total Harga Beli"] == "000") {
                      incompleteProducts.add(element);
                    }
                  }

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        JsonTable(
                          jsonRecordData,
                          onRowSelect: ((index, map) {
                            final Map<String, dynamic> stringifiedProduct = jsonDecode(
                                map["PI"]
                                    .toString()
                                    .substring(18, map["PI"].toString().length));

                            final Product productInstance =
                                Product.fromJson(stringifiedProduct);

                            RouteWrapper.push(context,
                                child: ProductEditorPage(
                                  existingProduct: productInstance,
                                ));
                          }),
                          tableHeaderBuilder: (value) {
                            if (value == "PI") {
                              return const SizedBox();
                            } else {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0,
                                  vertical: 10.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  border: Border.all(
                                    width: 0.5,
                                    color: AppTheme.colors.outline,
                                  ),
                                ),
                                child: Text(
                                  value ?? "_header_",
                                  textAlign: TextAlign.center,
                                  style: AppTheme.text.subtitle
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                              );
                            }
                          },
                          tableCellBuilder: (value) {
                            if ((value as String).contains("Product Instance: ")) {
                              return const SizedBox();
                            } else {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0,
                                  vertical: 10.0,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 0.5,
                                    color: AppTheme.colors.outline,
                                  ),
                                ),
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                  style: AppTheme.text.subtitle,
                                ),
                              );
                            }
                          },
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                            color: AppTheme.colors.surface.withOpacity(0.75),
                          ),
                          margin: const EdgeInsets.all(16.0).copyWith(bottom: 0.0),
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Icon(
                                  Ionicons.cash_outline,
                                  color: AppTheme.colors.success,
                                ),
                              ),
                              Text(
                                "Total Pendapatan: ${state.recordItems.last["Total Pendapatan"]}",
                                style: AppTheme.text.subtitle,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                            color: AppTheme.colors.surface.withOpacity(0.75),
                          ),
                          margin: const EdgeInsets.all(16.0).copyWith(top: 8.0),
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Icon(
                                  Ionicons.analytics_outline,
                                  color: AppTheme.colors.success,
                                ),
                              ),
                              Text(
                                "Total Laba: ${state.recordItems.last["Total Laba"]}",
                                style: AppTheme.text.subtitle,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                            color: AppTheme.colors.tertiary,
                          ),
                          margin: const EdgeInsets.all(16.0),
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(Ionicons.warning_outline,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      "Produk Tanpa Harga Beli!",
                                      style: AppTheme.text.subtitle.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Wrap(
                                direction: Axis.vertical,
                                spacing: 6.0,
                                children: List.generate(
                                  incompleteProducts.length,
                                  (index) {
                                    return Text(
                                      (index + 1).toString() +
                                          ". " +
                                          incompleteProducts.toList()[index]
                                              ["Nama Produk"],
                                      style: AppTheme.text.footnote.copyWith(
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
              } else if (state is SheetsStateLoading) {
                return const CustomLoadingIndicator();
              } else if (state is SheetsStateFailed) {
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
