

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:formz/formz.dart';
import 'package:ionicons/ionicons.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:sindu_store/app/auth/bloc/auth_bloc.dart';
import 'package:sindu_store/app/invoice/bloc/invoice_bloc.dart';
import 'package:sindu_store/app/navigation/cubit/navigation_cubit.dart';
import 'package:sindu_store/app/product/product/bloc/product_bloc.dart';
import 'package:sindu_store/app/ui_helpers/sliver_app_bar/cubit/sliver_cubit.dart';
import 'package:sindu_store/config/media_query.dart';
import 'package:sindu_store/config/theme.dart';
import 'package:sindu_store/model/invoice/invoice.dart';
import 'package:sindu_store/repository/invoice/invoice_repository.dart';
import 'package:sindu_store/repository/product/product_repository.dart';
import 'package:sindu_store/view/widgets/widgets.dart';
import 'package:sindu_store/repository/auth/auth_repository.dart';

part 'auth/onboarding_page.dart';
part 'auth/pin_input_page.dart';
part 'auth/auth_page.dart';

part 'home/dashboard_page.dart';
part 'home/profile_page.dart';
part 'home/home_wrapper_page.dart';
part 'home/qr_scan_page.dart';

part 'invoice/invoice_product_list_page.dart';
part 'invoice/invoice_checkout_page.dart';

part 'splash/splash_page.dart';