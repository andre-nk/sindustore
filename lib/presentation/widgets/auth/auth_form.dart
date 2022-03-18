part of "../widgets.dart";

class AuthForm extends StatelessWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.formStatus.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content:
                      Text(state.errorMessage ?? 'Authentication Failure'),
                ),
              );
          } else if (state.authStatus.index == 3) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Unknown user!'),
                ),
              );
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MQuery.height(0.01, context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _FormTitle(),
              _EmailAuthInput(),
              _SubmitButton(),
            ],
          ),
        ));
  }
}

class _FormTitle extends StatelessWidget {
  const _FormTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        // Logger().d("isEmailSubmitted:" +
        //     state.formStatus.isSubmissionSuccess.toString());
        // Logger().d("isPasswordUnfilled:" + state.password.pure.toString());

        return Padding(
          padding: EdgeInsets.only(
              top: MQuery.height(0.08, context),
              bottom: MQuery.height(0.005, context)),
          child: Text(
            (state.authStatus.index == 1 || state.authStatus.index == 2)
                ? "Masukkan password kamu:"
                : "Masukkan e-mail kamu:",
            style: AppTheme.text.h2.copyWith(fontSize: 24),
          ),
        );
      },
    );
  }
}

class _EmailAuthInput extends StatelessWidget {
  const _EmailAuthInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
        buildWhen: ((previous, current) =>
            previous.email != current.email),
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                key: const Key('loginForm_emailInput_textField'),
                onChanged: (email) =>
                    {context.read<AuthCubit>().emailFormChanged(email)},
                style: AppTheme.text.paragraph,
                decoration: const InputDecoration(
                  fillColor: Colors.cyan,
                  border: InputBorder.none,
                  hintText: 'contoh: andreas@gmail.com',
                  helperText: '',
                  errorText: null,
                ),
              ),
            ],
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
            ? CircularProgressIndicator(color: AppTheme.colors.secondary)
            : WideButton(
                title: "Lanjut",
                onPressed: () async {
                  state.formStatus.isValidated
                      ? await context.read<AuthCubit>().validateEmail()
                      : null;
                });
      },
    );
  }
}
