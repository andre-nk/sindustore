part of "../widgets.dart";

class GeneralAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Icon? overridePrimaryButtonIcon;
  final VoidCallback? primaryButtonOnPressed;
  final Widget? secondaryButton;
  final Widget? singleAction;

  const GeneralAppBar({
    Key? key,
    required this.title,
    this.overridePrimaryButtonIcon,
    this.primaryButtonOnPressed,
    this.secondaryButton,
    this.singleAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.zero,
        iconSize: 24,
        splashRadius: 24,
        onPressed: primaryButtonOnPressed ??
            () {
              Navigator.of(context).pop();
            },
        icon: overridePrimaryButtonIcon ??
            const Icon(
              Ionicons.chevron_back,
              size: 24,
            ),
      ),
      leadingWidth: 56,
      titleSpacing: MQuery.width(0, context),
      backgroundColor: AppTheme.colors.background,
      title: SizedBox(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoSizeText(
              title,
              textAlign: TextAlign.center,
              style: AppTheme.text.paragraph
                  .copyWith(height: 1.67, fontWeight: FontWeight.w600),
            ),
            secondaryButton ?? const SizedBox()
          ],
        ),
      ),
      actions: [singleAction ?? const SizedBox()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}
