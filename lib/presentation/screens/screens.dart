import 'package:auto_route/auto_route.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:sindu_store/app/auth/bloc/app_bloc.dart';
import 'package:sindu_store/app/auth/cubit/auth_cubit.dart';
import 'package:sindu_store/app/auth/cubit/auth_enums.dart';
import 'package:sindu_store/config/media_query.dart';
import 'package:sindu_store/config/theme.dart';
import 'package:sindu_store/presentation/widgets/widgets.dart';
import 'package:sindu_store/repository/auth/auth_repository.dart';
import 'package:sindu_store/routes/router.gr.dart';

part 'auth/onboarding_page.dart';
part 'auth/pin_input_page.dart';
part 'auth/auth_page.dart';

part 'home/home_page.dart';

part 'splash/splash_page.dart';

part 'app_view.dart';