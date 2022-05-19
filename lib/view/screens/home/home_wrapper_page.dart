part of "../screens.dart";

class HomeWrapperPage extends StatelessWidget {
  const HomeWrapperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(AuthRepository())..add(const AuthEventInitialize()),
        ),
      ],
      child: BlocBuilder<NavigationCubit, int>(
        builder: (context, state) {
          return Scaffold(
            body: state == 0 ? const DashboardPage() : const ProfilePage(),
            floatingActionButton: const CustomFAB(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: const CustomBottomNavbar(),
          );
        },
      ),
    );
  }
}
