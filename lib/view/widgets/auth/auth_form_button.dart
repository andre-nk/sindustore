part of "../widgets.dart";

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return WideButton(
          title: "Lanjut",
          onPressed: () async {
            if (state is AuthStateEmailChanged && state.formStatus.isValid) {
              context.read<AuthBloc>().add(AuthEventVerifyEmail(email: state.email.value));
            } else if (state is AuthStatePasswordChanged &&
                state.emailStatus == EmailVerificationStatus.existedUser) {
              context.read<AuthBloc>().add(AuthEventSignIn(
                  email: state.email.value, password: state.password.value));
            } else if (state is AuthStatePasswordChanged &&
                state.emailStatus == EmailVerificationStatus.predefinedUser) {
              context.read<AuthBloc>().add(AuthEventSignUp(
                  email: state.email.value, password: state.password.value));
            }
          },
        );
      },
    );
  }
}