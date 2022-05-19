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
                  bodyMedium: AppTheme.text.paragraph
                      .copyWith(color: AppTheme.colors.primary),
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
                    ),
                  );
                } else {
                  final jsonRecordData = state.recordItems
                      .sublist(0, state.recordItems.length - 1);

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        JsonTable(
                          jsonRecordData,
                          tableHeaderBuilder: (value) {
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
                          },
                          tableCellBuilder: (value) {
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
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, left: 16.0),
                          child: Text(
                            "Total Pendapatan: ${state.recordItems.last["Total Pendapatan"]}",
                            style: AppTheme.text.paragraph,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0, left: 16.0, bottom: 16.0),
                          child: Text(
                            "Total Laba: ${state.recordItems.last["Total Laba"]}",
                            style: AppTheme.text.paragraph,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              } else if (state is SheetsStateLoading) {
                return const CustomLoadingIndicator();
              } else if (state is SheetsStateFailed) {
                print(state.exception);
                return const SizedBox();
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
