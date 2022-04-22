part of "../widgets.dart";

class FormTitle extends StatelessWidget {
  const FormTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Text(
          (state is AuthStateInitial || state is AuthStateEmailChanged)
              ? "Masukkan e-mail kamu:"
              : "Masukkan password kamu:",
          style: AppTheme.text.h2.copyWith(fontSize: 24),
        );
      },
    );
  }
}