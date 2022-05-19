part of "../widgets.dart";

class CustomFAB extends StatelessWidget {
  const CustomFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[900]!.withOpacity(0.05),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, -2), // changes position of shadow
          ),
        ],
        border: Border.all(color: Colors.white, width: 4),
        shape: BoxShape.circle,
      ),
      child: FloatingActionButton(
        elevation: 0,
        onPressed: () {},
        child: Icon(
          Ionicons.add,
          color: AppTheme.colors.secondary,
          size: 32,
        ),
        backgroundColor: AppTheme.colors.primary,
      ),
    );
  }
}
