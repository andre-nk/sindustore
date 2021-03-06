part of "../widgets.dart";

class PasswordAuthInput extends StatefulWidget {
  const PasswordAuthInput({Key? key}) : super(key: key);

  @override
  State<PasswordAuthInput> createState() => _PasswordAuthInputState();
}

class _PasswordAuthInputState extends State<PasswordAuthInput> {
  bool _isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: ((previous, current) {
        if (previous is AuthStateEmailVerified && current is AuthStatePasswordChanged) {
          return true;
        } else if (previous is AuthStatePasswordChanged &&
            current is AuthStatePasswordChanged) {
          if (previous.password.value != current.password.value) {
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
          padding: EdgeInsets.only(bottom: MQuery.height(0.02, context)),
          child: TextField(
            obscureText: _isPasswordObscured,
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) => {
              context.read<AuthBloc>().add(
                    AuthEventPasswordFormChanged(
                      email: state is AuthStateEmailVerified
                          ? state.email.value
                          : (state as AuthStatePasswordChanged).email.value,
                      emailStatus: state is AuthStateEmailVerified
                          ? state.emailStatus
                          : (state as AuthStatePasswordChanged).emailStatus,
                      password: password,
                    ),
                  )
            },
            style: AppTheme.text.paragraph,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Password kamu...',
              suffixIcon: IconButton(
                splashRadius: 24,
                onPressed: () {
                  setState(() {
                    _isPasswordObscured = !_isPasswordObscured;
                  });
                },
                icon: _isPasswordObscured
                    ? const Icon(
                        Ionicons.eye_off_outline,
                        size: 20,
                      )
                    : const Icon(Ionicons.eye_outline, size: 20),
              ),
              errorText: state.exception != null &&
                      state.exception is LogInWithEmailAndPasswordFailure
                  ? "*Password salah. Silahkan coba lagi"
                  : null,
              isCollapsed: false,
              isDense: false,
            ),
          ),
        );
      },
    );
  }
}