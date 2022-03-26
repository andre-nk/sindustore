part of "../widgets.dart";

class AuthForm extends StatelessWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listenWhen: (previous, current) {
      return previous.authStatus != current.authStatus;
    }, listener: (context, state) {
      if (state.formStatus.isSubmissionFailure) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              backgroundColor: AppTheme.colors.error,
              content: Text(state.errorMessage ?? 'Authentication Failure',
                  style: AppTheme.text.subtitle.copyWith(color: Colors.white)),
            ),
          );
      } else if (state.authStatus == AuthStatusWrapper.unknownUser) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              backgroundColor: AppTheme.colors.error,
              content: Text(
                  state.errorMessage ?? 'E-mail pengguna tidak ditemukan!',
                  style: AppTheme.text.subtitle.copyWith(color: Colors.white)),
            ),
          );
      }
    }, builder: (context, state) {
      return (state.authStatus == AuthStatusWrapper.existedUser ||
              state.authStatus == AuthStatusWrapper.predefinedUser
          ? Column(
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
                      padding: EdgeInsets.only(top: 4.0, bottom: 12.0),
                      child: _PasswordAuthInput(),
                    )),
                _SubmitButton(),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(top: 56.0),
                  child: _FormTitle(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: _EmailAuthInput(isValidated: false),
                ),
                _SubmitButton(),
              ],
            ));
    });
  }
}

class _FormTitle extends StatelessWidget {
  const _FormTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Text(
          (state.authStatus.index == 1 || state.authStatus.index == 2)
              ? "Masukkan password kamu:"
              : "Masukkan e-mail kamu:",
          style: AppTheme.text.h2.copyWith(fontSize: 24),
        );
      },
    );
  }
}

class _EmailAuthInput extends StatelessWidget {
  final bool isValidated;
  const _EmailAuthInput({Key? key, required this.isValidated})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
        buildWhen: ((previous, current) =>
            (previous.email != current.email) ||
            (previous.formStatus != current.formStatus)),
        builder: (context, state) {
          return Padding(
            padding: isValidated
                ? EdgeInsets.symmetric(vertical: MQuery.height(0.02, context))
                : EdgeInsets.only(bottom: MQuery.height(0.04, context)),
            child: TextField(
              key: const Key('loginForm_emailInput_textField'),
              onChanged: (email) =>
                  {context.read<AuthCubit>().emailFormChanged(email)},
              style: AppTheme.text.paragraph,
              decoration: InputDecoration(
                enabled: !isValidated,
                border: InputBorder.none,
                hintText: isValidated
                    ? state.email.value
                    : 'contoh: andreas@gmail.com',
                errorText: state.formStatus.isSubmissionFailure
                    ? "*E-mail tidak valid. Coba lagi"
                    : null,
                suffixIcon: isValidated
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
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
        });
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
    return BlocBuilder<AuthCubit, AuthState>(
        buildWhen: ((previous, current) =>
            previous.password != current.password ||
            previous.formStatus != current.formStatus),
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(bottom: MQuery.height(0.02, context)),
            child: TextField(
              obscureText: _isPasswordObscured,
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  {context.read<AuthCubit>().passwordFormChanged(password)},
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
                errorText: state.formStatus.isSubmissionFailure
                    ? state.errorMessage ??
                        "*Password tidak valid (min. 6 karakter). Coba lagi"
                    : null,
                isCollapsed: false,
                isDense: false,
              ),
            ),
          );
        });
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: ((previous, current) =>
          previous.formStatus != current.formStatus),
      builder: (context, state) {
        return state.formStatus.isSubmissionInProgress
            ? Center(
                child:
                    CircularProgressIndicator(color: AppTheme.colors.secondary))
            : WideButton(
                title: "Lanjut",
                onPressed: () async {
                  if (state.authStatus == AuthStatusWrapper.emptyUser) {
                    print("E-mail Validation");
                    await context.read<AuthCubit>().validateEmail();
                  } else if (state.authStatus ==
                      AuthStatusWrapper.existedUser) {
                    print("Sign In");
                    // await context.read<AuthCubit>().signInWithEmailAndPassword();
                  } else if (state.authStatus ==
                      AuthStatusWrapper.predefinedUser) {
                    print("Sign Up");
                    await context
                        .read<AuthCubit>()
                        .signUpWithEmailAndPassword();
                  }
                });
      },
    );
  }
}
