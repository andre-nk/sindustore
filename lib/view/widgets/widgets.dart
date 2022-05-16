import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:deep_collection/deep_collection.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sindu_store/app/auth/bloc/auth_bloc.dart';
import 'package:sindu_store/app/invoice/bloc/invoice_bloc.dart';
import 'package:sindu_store/app/invoice/cubit/invoice_cubit.dart';
import 'package:sindu_store/app/navigation/cubit/navigation_cubit.dart';
import 'package:sindu_store/app/printer/bloc/printer_bloc.dart';
import 'package:sindu_store/app/product/discount/bloc/discount_bloc.dart';
import 'package:sindu_store/app/product/product/bloc/product_bloc.dart';
import 'package:sindu_store/app/product/tags/bloc/tags_bloc.dart';
import 'package:sindu_store/app/ui_helpers/sliver_app_bar/cubit/sliver_cubit.dart';
import 'package:sindu_store/config/media_query.dart';
import 'package:sindu_store/config/route_wrapper.dart';
import 'package:sindu_store/config/theme.dart';
import 'package:sindu_store/model/invoice/invoice.dart';
import 'package:sindu_store/model/invoice/invoice_item.dart';
import 'package:sindu_store/model/invoice/invoice_status.dart';
import 'package:sindu_store/model/product/product.dart';
import 'package:sindu_store/repository/auth/auth_exceptions.dart';
import 'package:sindu_store/repository/invoice/invoice_repository.dart';
import 'package:sindu_store/repository/product/discount_repository.dart';
import 'package:sindu_store/repository/product/product_repository.dart';
import 'package:sindu_store/repository/product/tags_repository.dart';
import 'package:sindu_store/view/screens/screens.dart';
part "general/app_bar.dart";
part "general/wide_button.dart";
part "general/loading_indicator.dart";

part "auth/auth_form.dart";
part "auth/auth_form_title.dart";
part "auth/auth_form_email.dart";
part "auth/auth_form_password.dart";
part "auth/auth_form_button.dart";

part "home/custom_fab.dart";
part "home/custom_bottom_navbar.dart";
part "home/main_box.dart";
part "home/dashboard_invoice_list.dart";
part 'invoice/invoice_card.dart';

part 'invoice/invoice_product_list_appbar.dart';
part 'invoice/invoice_product_list_fab.dart';
part 'invoice/invoice_checkout_sheet.dart';
part 'invoice/invoice_checkout_header.dart';
part 'invoice/invoice_product_sliver_list.dart';
part 'invoice/invoice_product_filter_tags.dart';
part 'invoice/invoice_back_modal.dart';
part 'invoice/invoice_delete_modal.dart';
part 'invoice/invoice_card_item_list.dart';
part 'invoice/invoice_card_value.dart';

part 'product/product_card.dart';
part 'product/product_quantity.dart';
part 'product/product_discount_dropdown.dart';
part 'product/product_bottomsheet.dart';
part 'product/product_discount_modal.dart';
