part of "../widgets.dart";

class ProductSliverAppBar extends StatelessWidget {
  const ProductSliverAppBar({Key? key, required this.state}) : super(key: key);
  final bool state;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        "Pilih produk",
        style: AppTheme.text.paragraph.copyWith(fontWeight: FontWeight.w500),
      ),
      leading: IconButton(
        icon: const Icon(Ionicons.chevron_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            icon: const Icon(
              Ionicons.receipt_outline,
              size: 22,
            ),
            onPressed: () {
              Navigator.pop(context);
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
        title: AnimatedOpacity(
          opacity: state ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 250),
          child: Container(
            margin: const EdgeInsets.all(20).copyWith(bottom: 0, top: 56),
            child: Column(
              children: [
                Expanded(
                  flex: 5,
                  child: TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      prefixIcon: Icon(
                        Ionicons.search,
                        size: 20,
                        color: AppTheme.colors.primary,
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
                      hintStyle:
                          AppTheme.text.subtitle.copyWith(color: AppTheme.colors.outline),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 0.0),
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Chip(
                            backgroundColor:
                                index == 0 ? AppTheme.colors.tertiary : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                              side: BorderSide(
                                width: index == 0 ? 0 : 1,
                                style: BorderStyle.solid,
                                color: AppTheme.colors.primary,
                              ),
                            ),
                            label: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Row(
                                children: [
                                  index == 0
                                      ? const Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Icon(
                                            Ionicons.filter,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        )
                                      : const SizedBox(),
                                  Text(
                                    "Filter",
                                    style: AppTheme.text.footnote.copyWith(
                                      color: index == 0
                                          ? Colors.white
                                          : AppTheme.colors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      expandedHeight: 175,
    );
  }
}
