part of "../widgets.dart";

class AuthForm extends StatelessWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppStateFailed) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                backgroundColor: AppTheme.colors.error,
                content: Text(
                  state.exception.toString(),
                  style: AppTheme.text.subtitle.copyWith(color: Colors.white),
                ),
              ),
            );
        }
      },
      builder: (context, state) {
        if (state is AppStateInitial ||
            state is AppStateEmailChanged ||
            (state is AppStateFailed && state.exception is InvalidEmailAuthException)) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 56.0),
                child: _FormTitle(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: _EmailAuthInput(
                  isValidated: false,
                ),
              ),
              _SubmitButton(),
            ],
          );
        } else if (state is AppStateEmailVerified ||
            state is AppStatePasswordChanged ||
            (state is AppStateFailed &&
                state.exception is LogInWithEmailAndPasswordFailure)) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 24),
                child: _EmailAuthInput(
                  isValidated: true,
                ),
              ),
              _FormTitle(),
              DelayedDisplay(
                  delay: Duration(milliseconds: 250),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 4.0,
                      bottom: 12.0,
                    ),
                    child: _PasswordAuthInput(),
                  )),
              _SubmitButton(),
            ],
          );
        } else if (state.isLoading) {
          return Center(child: CircularProgressIndicator(color: AppTheme.colors.primary));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class _FormTitle extends StatelessWidget {
  const _FormTitle({Key? key}) : super(key: key);

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

class _EmailAuthInput extends StatelessWidget {
  final bool isValidated;
  const _EmailAuthInput({Key? key, required this.isValidated}) : super(key: key);

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

class _PasswordAuthInput extends StatefulWidget {
  const _PasswordAuthInput({Key? key}) : super(key: key);

  @override
  State<_PasswordAuthInput> createState() => _PasswordAuthInputState();
}

class _PasswordAuthInputState extends State<_PasswordAuthInput> {
  bool _isPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      buildWhen: ((previous, current) {
        if (previous is AppStateEmailVerified && current is AppStatePasswordChanged) {
          return true;
        } else if (previous is AppStatePasswordChanged &&
            current is AppStatePasswordChanged) {
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
              context.read<AppBloc>().add(
                    AppEventPasswordFormChanged(
                      email: (state as AppStatePasswordChanged).email.value,
                      emailStatus: state.emailStatus,
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
              errorText:
                  state is AppStateFailed && state.exception is LogInWithEmailAndPasswordFailure
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

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

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
