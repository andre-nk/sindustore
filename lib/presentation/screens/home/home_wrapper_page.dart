part of "../screens.dart";

class HomeWrapperPage extends StatelessWidget {
  const HomeWrapperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
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
          onPressed: () {
            // context.router.push(const QRScanRoute());
          },
          child: Icon(
            Ionicons.add,
            color: AppTheme.colors.secondary,
            size: 32,
          ),
          backgroundColor: AppTheme.colors.primary,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 10,
        // currentIndex: tabsRouter.activeIndex,
        // onTap: tabsRouter.setActiveIndex,
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
      ),
    );
  }
}
