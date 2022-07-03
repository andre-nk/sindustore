part of "../widgets.dart";

class InvoiceProductListAppBar extends StatefulWidget {
  const InvoiceProductListAppBar({
    Key? key,
    this.existingInvoice,
    this.existingInvoiceUID,
    this.dashboardSearchQuery = "",
  }) : super(key: key);

  final Invoice? existingInvoice;
  final String? existingInvoiceUID;
  final String dashboardSearchQuery;

  @override
  State<InvoiceProductListAppBar> createState() => _InvoiceProductListAppBarState();
}

class _InvoiceProductListAppBarState extends State<InvoiceProductListAppBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.dashboardSearchQuery;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return SliverAppBar(
          title: AutoSizeText(
            widget.existingInvoice != null ? "Perbarui nota" : "Pilih produk",
            style: AppTheme.text.subtitle.copyWith(fontWeight: FontWeight.w500),
          ),
          leading: BlocConsumer<InvoiceBloc, InvoiceState>(
            listener: (context, state) {
              if (state is InvoiceStateCreated) {
                RouteWrapper.removeAllAndPush(context, child: const HomeWrapperPage());
              }
            },
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Ionicons.chevron_back),
                onPressed: () {
                  if (state is InvoiceStateActivated) {
                    if (widget.existingInvoice != null) {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return InvoiceBackModal(
                            invoice: state.invoice,
                            existingInvoiceUID: widget.existingInvoiceUID,
                            ancestorContext: context,
                          );
                        },
                      );
                    } else if (widget.existingInvoice == null &&
                        state.invoice.products.isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return InvoiceBackModal(
                            invoice: state.invoice,
                            ancestorContext: context,
                          );
                        },
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  } else {
                    Navigator.pop(context);
                  }
                },
              );
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Ionicons.add_circle_outline,
                size: 24,
              ),
              onPressed: () {
                RouteWrapper.push(context, child: const ProductEditorPage());
              },
            ),
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: const Icon(
                  Ionicons.receipt_outline,
                  size: 22,
                ),
                onPressed: () {
                  RouteWrapper.push(context, child: const InvoiceListPage());
                },
              ),
            ),
          ],
          titleSpacing: 0,
          backgroundColor: Colors.white,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            expandedTitleScale: 1.0,
            centerTitle: true,
            title: BlocBuilder<SliverCubit, SliverState>(
              builder: (context, state) {
                return AnimatedOpacity(
                  opacity: state is! SliverHideAppBar ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 250),
                  child: Container(
                    margin: const EdgeInsets.only(top: 56),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextField(
                              onChanged: (value) {
                                context.read<ProductBloc>().add(
                                      ProductEventSearchActive(searchQuery: value),
                                    );
                              },
                              controller: _searchController,
                              decoration: InputDecoration(
                                isDense: true,
                                prefixIcon: Icon(
                                  Ionicons.search,
                                  size: 20,
                                  color: AppTheme.colors.primary,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _searchController.clear();
                                    });
                                  },
                                  icon: Icon(
                                    Ionicons.close_circle_outline,
                                    size: 20,
                                    color: AppTheme.colors.primary,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: AppTheme.colors.primary,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(4),
                                hintText: "Cari produk di toko...",
                                hintStyle: AppTheme.text.subtitle.copyWith(
                                  color: AppTheme.colors.outline,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InvoiceProductFilterTags(state: state)
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          expandedHeight: 175,
        );
      },
    );
  }
}
