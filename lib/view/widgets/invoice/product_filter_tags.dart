part of "../widgets.dart";

class ProductFilterTags extends StatelessWidget {
  const ProductFilterTags({Key? key, required this.state}) : super(key: key);

  final SliverState state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Center(
        child: BlocProvider(
          create: (context) => TagsBloc(TagsRepository())..add(TagsEventFetch()),
          child: BlocBuilder<TagsBloc, TagsState>(
            buildWhen: ((previous, current) {
              if (previous is TagsStateLoaded && current is TagsStateSelected) {
                return true;
              } else if (previous is TagsStateSelected && current is TagsStateSelected) {
                if (previous.activeTagIndex != current.activeTagIndex) {
                  return true;
                } else {
                  return false;
                }
              } else {
                return true;
              }
            }),
            builder: (context, state) {
              if (state is TagsStateFetching) {
                return const SizedBox();
              } else if (state is TagsStateLoaded || state is TagsStateSelected) {
                return ListView.builder(
                  padding: state is! SliverHorizontalLeaveStart
                      ? const EdgeInsets.only(left: 20)
                      : EdgeInsets.zero,
                  itemCount: state.productTags.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    if (toBeginningOfSentenceCase(state.productTags[index]) != null) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 4.0,
                        ).copyWith(right: 12.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: state is TagsStateSelected &&
                                      state.activeTagIndex != null &&
                                      state.activeTagIndex == index
                                  ? AppTheme.colors.tertiary
                                  : Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8.0)),
                                side: BorderSide(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: state is TagsStateSelected &&
                                          state.activeTagIndex == index
                                      ? Colors.transparent
                                      : AppTheme.colors.primary,
                                ),
                              ),
                              elevation: 0),
                          onPressed: () {
                            if (state is TagsStateLoaded ||
                                (state is TagsStateSelected &&
                                    index != state.activeTagIndex)) {
                              context.read<TagsBloc>().add(
                                    TagsEventSelect(
                                        tags: state.productTags, activeTagIndex: index),
                                  );
                            } else {
                              context.read<TagsBloc>().add(
                                    TagsEventSelect(
                                        tags: state.productTags, activeTagIndex: null),
                                  );
                            }

                            context.read<ProductBloc>().add(ProductEventFilter(filterTag: state.productTags[index]));
                          },
                          child: Text(
                            toBeginningOfSentenceCase(state.productTags[index])!,
                            style: AppTheme.text.footnote.copyWith(
                              color: state is TagsStateSelected &&
                                      state.activeTagIndex == index
                                  ? Colors.white
                                  : AppTheme.colors.primary,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                );
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
