part of "../screens.dart";

class PINInputPage extends StatelessWidget {
  const PINInputPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: PINInputPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.colors.background,
        title: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/logo_wide.png",
                height: 24,
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 24,
                  splashRadius: 24,
                  onPressed: () {},
                  icon: const Icon(
                    Ionicons.help_circle_outline,
                    size: 24,
                  )),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: MQuery.width(0.05, context)),
        width: MQuery.width(1, context),
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MQuery.height(0.125, context),
                bottom: MQuery.height(0.1, context),
              ),
              child: Image.asset(
                "assets/pin_illustration.png",
                height: MQuery.height(0.15, context),
              ),
            ),
            Column(
              children: [
                Text(
                  "Verifikasi PIN kamu",
                  style: AppTheme.text.h2.copyWith(fontSize: 24),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MQuery.height(0.03, context),
                    horizontal: MQuery.width(0.125, context),
                  ),
                  child: BlocConsumer<AppBloc, AppState>(
                    buildWhen: (previous, current) {
                      if (previous is AppStateLoggedIn && current is AppStatePINChanged) {
                        return true;
                      } else if ((previous as AppStatePINChanged).pin.value !=
                          (current as AppStatePINChanged).pin.value) {
                        return true;
                      } else if (previous.formStatus != current.formStatus) {
                        return true;
                      } else {
                        return false;
                      }
                    },
                    listener: (context, state) {
                      if (state is AppStatePINChanged && state.pin.value.length == 6) {
                        context
                            .read<AppBloc>()
                            .add(AppEventVerifyPIN(pin: state.pin.value));

                        context.read<AppBloc>().add(const AppEventVerifyPIN(pin: ""));
                      } else if (state is AppStateLoggedIn && state.isPINCorrect) {
                        context.router.replaceNamed("/home");
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(6, (index) {
                              return Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: state is AppStatePINChanged &&
                                          state.pin.value.length > index
                                      ? AppTheme.colors.secondary
                                      : Colors.white,
                                  border: Border.all(
                                    color: AppTheme.colors.primary
                                        .withOpacity(0.25), // Set border color
                                    width: 3.0,
                                  ), // Set border width
                                ),
                              );
                            }),
                          ),
                          state is AppStatePINChanged &&
                                  state.formStatus == FormzStatus.invalid
                              ? DelayedDisplay(
                                  delay: const Duration(milliseconds: 50),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 24.0),
                                    child: Text(
                                      "PIN salah! Coba lagi",
                                      style: AppTheme.text.subtitle.copyWith(
                                        color: AppTheme.colors.error,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox()
                        ],
                      );
                    },
                  ),
                ),
                BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                    return NumericKeyboard(
                      onKeyboardTap: (str) {
                        if ((runtimeType is AppStateLoggedIn ||
                            state is AppStatePINChanged && state.pin.value.length != 6)) {
                          context.read<AppBloc>().add(AppEventPINFormChanged(
                              pin: state is AppStateLoggedIn
                                  ? str
                                  : (state as AppStatePINChanged).pin.value + str));
                        }
                      },
                      textColor: AppTheme.colors.primary,
                      rightButtonFn: () {
                        if (state is AppStatePINChanged) {
                          String currentPIN = state.pin.value;

                          if (currentPIN.isNotEmpty) {
                            context.read<AppBloc>().add(AppEventPINFormChanged(
                                pin: currentPIN.substring(0, currentPIN.length - 1)));
                          }
                        }
                      },
                      rightIcon: Icon(
                        Ionicons.backspace,
                        color: AppTheme.colors.secondary,
                      ),
                      leftButtonFn: () {
                        context.read<AppBloc>().add(AppEventValidateBiometric());
                      },
                      leftIcon: Icon(
                        Ionicons.finger_print,
                        color: AppTheme.colors.secondary,
                      ),
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
