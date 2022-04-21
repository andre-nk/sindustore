part of "../widgets.dart";

class EmailAuthInput extends StatelessWidget {
  final bool isValidated;
  const EmailAuthInput({Key? key, required this.isValidated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: ((previous, current) {
        if (previous is AppStateInitial && current is AppStateEmailChanged) {
          return true;
        } else if (previous is AppStateEmailChanged && current is AppStateEmailChanged) {
          if (previous.email.value != current.email.value) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      }),
      builder: (context, state) {
        return Padding(
          padding: isValidated
              ? EdgeInsets.symmetric(vertical: MQuery.height(0.02, context))
              : EdgeInsets.only(bottom: MQuery.height(0.04, context)),
          child: TextField(
            key: const Key('loginForm_emailInput_textField'),
            onChanged: (email) =>
                {context.read<AppBloc>().add(AppEventEmailFormChanged(email: email))},
            style: AppTheme.text.paragraph,
            decoration: InputDecoration(
              enabled: !isValidated,
              border: InputBorder.none,
              hintText: isValidated && state is AppStateEmailVerified
                  ? state.email.value
                  : isValidated && state is AppStatePasswordChanged
                      ? state.email.value
                      : 'contoh: andreas@gmail.com',
              errorText:
                  state is AppStateEmailChanged && state.formStatus == FormzStatus.invalid
                      ? "*E-mail tidak valid. Coba lagi"
                      : null,
              suffixIcon: isValidated
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Icon(
                        Ionicons.checkmark,
                        color: AppTheme.colors.success,
                      ),
                    )
                  : const SizedBox(),
              isCollapsed: false,
              isDense: false,
            ),
          ),
        );
      },
    );
  }
}