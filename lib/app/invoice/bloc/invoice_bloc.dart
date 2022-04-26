import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sindu_store/model/invoice/invoice.dart';
import 'package:sindu_store/model/invoice/invoice_item.dart';
import 'package:sindu_store/model/invoice/invoice_status.dart';
import 'package:sindu_store/model/product/product_discount.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc() : super(const InvoiceStateInitial()) {
    on<InvoiceEventActivate>((event, emit) {
      try {
        final Invoice invoice = Invoice(
          adminHandlerUID: event.adminHandlerUID,
          customerName: "",
          products: const [],
          status: InvoiceStatus.pending,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        //? INVOICE COULD BE GENERATED FROM HERE AND WILL BE UPDATED A LONG THE WAY
        //? OR WE MAINTAIN THE INVOICE STATE AS A LOCAL DB BEFORE THE ADMIN REACHED CHECKOUT PAGE

        emit(InvoiceStateActivated(invoice: invoice));
      } on Exception catch (e) {
        throw InvoiceStateInitial(exception: e);
      }
    });

    on<InvoiceEventRead>((event, emit) {
      try {
        //? OR PASS THE INVOICE ID FOR THE REPOSITORY FETCH
        emit(InvoiceStateActivated(invoice: event.invoice));
      } on Exception catch (e) {
        throw InvoiceStateInitial(exception: e);
      }
    });

    on<InvoiceEventAddItem>((event, emit) {
      try {
        //COPY
        Invoice invoice = event.invoice;

        //MODIFY PRODUCT LIST
        for (var i = 0; i < invoice.products.length; i++) {
          InvoiceItem product = invoice.products[i];

          if (product.productID == event.productID) {
            //IF EXISTS, REPLACE WITH THE SAME DATA, EXCEPT QTY + 1
            product = InvoiceItem(
              quantity: product.quantity + 1,
              productID: product.productID,
              discount: product.discount,
            );

            break;
          } else if (product.productID != event.productID) {
            //IF DOESN'T EXIST, ADD A NEW ONE THEN BREAK THE LOOP SINCE THERE WILL BE MANY MORE INEQUALITY OF PRODUCT ID
            invoice.products.add(
              InvoiceItem(
                quantity: 1,
                productID: event.productID,
                discount: 0.0,
              ),
            );

            break;
          }
        }

        emit(InvoiceStateActivated(invoice: invoice));
      } on Exception catch (e) {
        //? THE ERROR WILL MAINTAIN PREVIOUS INVOICE STATE AS WELL THE EXCEPTION
        throw InvoiceStateActivated(invoice: event.invoice, exception: e);
      }
    });

    on<InvoiceEventRemoveItem>((event, emit) {
      try {
        //COPY
        Invoice invoice = event.invoice;

        //MODIFY PRODUCT LIST
        for (var i = 0; i < invoice.products.length; i++) {
          InvoiceItem product = invoice.products[i];

          if (product.productID == event.productID) {
            if (product.quantity > 0) {
              //IF EXISTS AND QTY IS MORE THAN 0, REPLACE WITH THE SAME DATA, EXCEPT QTY - 1
              product = InvoiceItem(
                quantity: product.quantity - 1,
                productID: product.productID,
                discount: product.discount,
              );

              break;
            } else {
              //IF EXISTS BUT QTY IS 0, BREAK THE LOOP AND DO NOTHING
              break;
            }
          } else if (product.productID != event.productID) {
            //IF DOESN'T EXIST, BREAK THE LOOP AND DO NOTHING (EMIT THE SAME STATE)
            break;
          }
        }

        emit(InvoiceStateActivated(invoice: invoice));
      } on Exception catch (e) {
        //? THE ERROR WILL MAINTAIN PREVIOUS INVOICE STATE AS WELL THE EXCEPTION
        throw InvoiceStateActivated(invoice: event.invoice, exception: e);
      }
    });

    on<InvoiceEventEditDiscount>((event, emit) {
      try {
        //COPY
        Invoice invoice = event.invoice;

        //MODIFY PRODUCT LIST (SPECIFICALLY ON DISCOUNT FIELD)
        for (var i = 0; i < invoice.products.length; i++) {
          InvoiceItem product = invoice.products[i];

          if (product.productID == event.productID) {
            product = InvoiceItem(
              quantity: product.quantity,
              productID: product.productID,
              discount: event.productDiscount.amount,
            );
          } else if (product.productID != event.productID) {
            //IF DOESN'T EXIST, BREAK THE LOOP AND DO NOTHING (EMIT THE SAME STATE)
            break;
          }
        }

        emit(InvoiceStateActivated(invoice: invoice));
      } on Exception catch (e) {
        //? THE ERROR WILL MAINTAIN PREVIOUS INVOICE STATE AS WELL THE EXCEPTION
        throw InvoiceStateActivated(invoice: event.invoice, exception: e);
      }
    });

    on<InvoiceEventMarkStatus>((event, emit) {
      try {
        final Invoice invoice = Invoice(
          adminHandlerUID: event.invoice.adminHandlerUID,
          customerName: event.invoice.customerName,
          products: event.invoice.products,
          status: event.status,
          createdAt: event.invoice.createdAt,
          updatedAt: DateTime.now(),
        );

        emit(InvoiceStateActivated(invoice: invoice));
      } on Exception catch (e) {
        throw InvoiceStateActivated(invoice: event.invoice, exception: e);
      }
    });

    on<InvoiceEventDeactivate>(((event, emit) {
      try {
        emit(const InvoiceStateDeactivated());
      } on Exception catch (e) {
        throw InvoiceStateDeactivated(exception: e);
      }
    }));
  }
}
