part of "../widgets.dart";

class ProductSliverAppBar extends StatelessWidget {
  const ProductSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return SliverAppBar(
          title: Text(
            "Pilih produk",
            style: AppTheme.text.subtitle.copyWith(fontWeight: FontWeight.w500),
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
                                hintStyle: AppTheme.text.subtitle.copyWith(
                                  color: AppTheme.colors.outline,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ProductFilterTags(state: state)
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
