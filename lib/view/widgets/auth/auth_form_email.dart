part of "../widgets.dart";

class EmailAuthInput extends StatelessWidget {
  final bool isValidated;
  const EmailAuthInput({Key? key, required this.isValidated}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: ((previous, current) {
        if (previous is AuthStateInitial && current is AuthStateEmailChanged) {
          return true;
        } else if (previous is AuthStateEmailChanged && current is AuthStateEmailChanged) {
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
                {context.read<AuthBloc>().add(AuthEventEmailFormChanged(email: email))},
            style: AppTheme.text.paragraph,
            decoration: InputDecoration(
              enabled: !isValidated,
              border: InputBorder.none,
              hintText: isValidated && state is AuthStateEmailVerified
                  ? state.email.value
                  : isValidated && state is AuthStatePasswordChanged
                      ? state.email.value
                      : 'contoh: andreas@gmail.com',
              errorText:
                  state is AuthStateEmailChanged && state.formStatus == FormzStatus.invalid
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