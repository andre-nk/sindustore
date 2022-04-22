part of "../widgets.dart";

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, state) {
        return BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 10,
          currentIndex: state,
          onTap: (index) {
            context.read<NavigationCubit>().navigateTo(index);
          },
          selectedLabelStyle: AppTheme.text.footnote.copyWith(
            color: AppTheme.colors.primary,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
          unselectedLabelStyle: AppTheme.text.footnote.copyWith(
            color: AppTheme.colors.outline,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
          unselectedIconTheme: IconThemeData(
            color: AppTheme.colors.outline,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Ionicons.home_outline),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Ionicons.home),
              ),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Ionicons.person_outline),
              ),
              activeIcon: Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Icon(Ionicons.person),
              ),
              label: 'Profil',
            ),
          ],
        );
      },
    );
  }
}
