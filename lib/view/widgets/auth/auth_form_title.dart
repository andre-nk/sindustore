part of "../widgets.dart";

class FormTitle extends StatelessWidget {
  const FormTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Text(
          (state is AppStateInitial || state is AppStateEmailChanged)
              ? "Masukkan e-mail kamu:"
              : "Masukkan password kamu:",
          style: AppTheme.text.h2.copyWith(fontSize: 24),
        );
      },
    );
  }
}