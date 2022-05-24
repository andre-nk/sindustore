part of "../screens.dart";

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MQuery.height(1, context),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: -1 * MQuery.width(1.005, context),
              child: Container(
                width: MQuery.width(1.5, context),
                height: MQuery.width(1.5, context),
                decoration: BoxDecoration(
                  color: AppTheme.colors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 48,
              child: Image.asset("assets/logo_yellow.png", height: 48),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MQuery.width(0.075, context),
              ).copyWith(top: MQuery.height(0.105, context)),
              child: Container(
                height: MQuery.height(0.27, context),
                margin: const EdgeInsets.only(top: 16),
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
                decoration: BoxDecoration(
                  color: AppTheme.colors.background,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x00535860).withOpacity(0.25),
                      offset: const Offset(0.0, 4.0),
                      blurRadius: 20,
                    )
                  ],
                ),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthStateLoggedIn) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText(
                            "Profil",
                            style: AppTheme.text.title,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 24.0,
                                      backgroundColor: AppTheme.colors.surface,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 2.0),
                                        child: Icon(
                                          Ionicons.person,
                                          size: 20.0,
                                          color: AppTheme.colors.primary,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 16.0),
                                      child: AutoSizeText(
                                        state.user.name,
                                        style: AppTheme.text.subtitle.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 6.0,
                                    horizontal: 10.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: state.user.role == UserRoles.admin
                                        ? AppTheme.colors.tertiary
                                        : state.user.role == UserRoles.owner
                                            ? AppTheme.colors.secondary
                                            : AppTheme.colors.primary,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                  ),
                                  child: AutoSizeText(
                                    state.user.role.name.capitalize(),
                                    style: AppTheme.text.footnote.copyWith(
                                      color: state.user.role == UserRoles.owner
                                          ? AppTheme.colors.primary
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: TextButton(
                              onPressed: () {
                                context.read<AuthBloc>().add(AuthEventResetPassword());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    "Setel ulang password",
                                    style: AppTheme.text.subtitle,
                                  ),
                                  const Icon(Ionicons.chevron_forward, size: 20.0)
                                ],
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(AuthEventSignOut());
                              RouteWrapper.removeAllAndPush(context, child: const OnboardingPage());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  "Keluar dari akun",
                                  style: AppTheme.text.subtitle.copyWith(
                                    color: AppTheme.colors.error,
                                  ),
                                ),
                                Icon(
                                  Ionicons.chevron_forward,
                                  size: 20.0,
                                  color: AppTheme.colors.error,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
