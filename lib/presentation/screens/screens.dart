import 'package:auto_route/auto_route.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:sindu_store/app/auth/cubit/auth_cubit.dart';
import 'package:sindu_store/app/auth/cubit/auth_enums.dart';
import 'package:sindu_store/config/media_query.dart';
import 'package:sindu_store/config/theme.dart';
import 'package:sindu_store/presentation/widgets/widgets.dart';
import 'package:sindu_store/repository/auth/auth_repository.dart';

part 'auth/onboarding_page.dart';
part 'auth/pin_input_page.dart';
part 'auth/auth_page.dart';

part 'home/dashboard_page.dart';
part 'home/profile_page.dart';
part 'home/home_wrapper_page.dart';
part 'home/qr_scan_page.dart';
part 'home/product_list_page.dart';

part 'splash/splash_page.dart';