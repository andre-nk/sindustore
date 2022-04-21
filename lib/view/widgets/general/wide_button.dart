part of "../widgets.dart";

class WideButton extends StatelessWidget {
  final String title;
  final bool disabled;
  final VoidCallback onPressed;

  const WideButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.disabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? () {} : onPressed,
      style: ElevatedButton.styleFrom(
        primary: disabled
            ? AppTheme.colors.primary.withOpacity(0.75)
            : AppTheme.colors.primary,
        shape: const StadiumBorder(),
        minimumSize: const Size(double.infinity, 54),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: AppTheme.text.paragraph.copyWith(
            fontWeight: FontWeight.w500,
            color: AppTheme.colors.secondary,
          ),
        ),
      ),
    );
  }
}
