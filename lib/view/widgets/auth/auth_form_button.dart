part of "../widgets.dart";

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return WideButton(
          title: "Lanjut",
          onPressed: () async {
            if (state is AppStateEmailChanged && state.formStatus.isValid) {
              context.read<AppBloc>().add(AppEventVerifyEmail(email: state.email.value));
            } else if (state is AppStatePasswordChanged &&
                state.emailStatus == EmailVerificationStatus.existedUser) {
              context.read<AppBloc>().add(AppEventSignIn(
                  email: state.email.value, password: state.password.value));
            } else if (state is AppStatePasswordChanged &&
                state.emailStatus == EmailVerificationStatus.predefinedUser) {
              context.read<AppBloc>().add(AppEventSignUp(
                  email: state.email.value, password: state.password.value));
            }
          },
        );
      },
    );
  }
}