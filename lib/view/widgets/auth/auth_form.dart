part of "../widgets.dart";

class AuthForm extends StatelessWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.exception != null) {
          String exceptionMessage = "";

          if (state.exception is LogInWithEmailAndPasswordFailure) {
            exceptionMessage =
                (state.exception as LogInWithEmailAndPasswordFailure).message;
          } else if (state.exception is SignUpWithEmailAndPasswordFailure) {
            exceptionMessage =
                (state.exception as SignUpWithEmailAndPasswordFailure).message;
          } else if (state.exception is UnknownUserException) {
            exceptionMessage =
                "E-mail ini tidak terdaftar di database toko. Hubungi admin!";
          }

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: AppTheme.colors.error,
                content: Text(
                  exceptionMessage,
                  style: AppTheme.text.subtitle.copyWith(color: Colors.white),
                ),
              ),
            );
        }
      },
      builder: (context, state) {
        if (state is AuthStateInitial || state is AuthStateEmailChanged) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 56.0),
                child: FormTitle(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: EmailAuthInput(
                  isValidated: false,
                ),
              ),
              SubmitButton(),
            ],
          );
        } else if (state is AuthStateEmailVerified ||
            state is AuthStatePasswordChanged ||
            (state.exception != null &&
                state.exception is LogInWithEmailAndPasswordFailure)) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 24),
                child: EmailAuthInput(
                  isValidated: true,
                ),
              ),
              FormTitle(),
              DelayedDisplay(
                  delay: Duration(milliseconds: 250),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 4.0,
                      bottom: 12.0,
                    ),
                    child: PasswordAuthInput(),
                  )),
              SubmitButton(),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
