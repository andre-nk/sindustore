part of "../screens.dart";

class AuthFormPage extends StatelessWidget {
  const AuthFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (_) => AuthCubit(context.read<AuthRepository>()),
      child: Scaffold(
          appBar: GeneralAppBar(
            title: "Log in",
            secondaryButton: IconButton(
                padding: EdgeInsets.zero,
                iconSize: 24,
                splashRadius: 24,
                onPressed: () {},
                icon: const Icon(
                  Ionicons.help_circle_outline,
                  size: 24,
                )),
          ),
          body: Padding(
            padding: EdgeInsets.only(
                top: 56,
                left: MQuery.width(0.075, context),
                right: MQuery.width(0.075, context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/login_illustration.png",
                    height: MQuery.height(0.15, context)),
                const AuthForm()
              ],
            ),
          )),
    );
  }
}
