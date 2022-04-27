import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sindu_store/model/invoice/invoice.dart';
import 'package:sindu_store/model/invoice/invoice_item.dart';
import 'package:sindu_store/model/invoice/invoice_status.dart';
import 'package:sindu_store/model/product/product_discount.dart';
import 'package:uuid/uuid.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc() : super(const InvoiceStateInitial()) {
    on<InvoiceEventActivate>((event, emit) async {
      try {
        final Invoice invoice = Invoice(
          adminHandlerUID: event.adminHandlerUID,
          customerName: "",
          products: [
            InvoiceItem(
              quantity: 1,
              productID: event.initialProductID,
              discount: 0,
            )
          ],
          status: InvoiceStatus.pending,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        //? INVOICE COULD BE GENERATED FROM HERE AND WILL BE UPDATED A LONG THE WAY
        //? OR WE MAINTAIN THE INVOICE STATE AS A LOCAL DB BEFORE THE ADMIN REACHED CHECKOUT PAGE

        emit(InvoiceStateActivated(invoice: invoice, key: const Uuid().v4()));
      } on Exception catch (e) {
        throw InvoiceStateInitial(exception: e);
      }
    });

    on<InvoiceEventRead>((event, emit) {
      try {
        //? OR PASS THE INVOICE ID FOR THE REPOSITORY FETCH
        emit(InvoiceStateActivated(invoice: event.invoice, key: const Uuid().v4()));
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
          if (invoice.products[i].productID == event.productID) {
            //"IFF EXISTS, REPLACE WITH THE SAME DATA, EXCEPT QTY + 1");
            invoice.products[i] = InvoiceItem(
              quantity: invoice.products[i].quantity + 1,
              productID: invoice.products[i].productID,
              discount: invoice.products[i].discount,
            );

            emit(InvoiceStateActivated(
              invoice: invoice,
              key: const Uuid().v4(),
            ));
            break;
          } else if (invoice.products[i].productID != event.productID) {
            //("IF DOESN'T EXIST, ADD A NEW ONE THEN BREAK THE LOOP");
            invoice.products.add(
              InvoiceItem(
                quantity: 1,
                productID: event.productID,
                discount: 0.0,
              ),
            );

            emit(InvoiceStateActivated(
              invoice: invoice,
              key: const Uuid().v4(),
            ));
            break;
          }
        }

        emit(InvoiceStateActivated(
          invoice: invoice,
          key: const Uuid().v4(),
        ));
      } on Exception catch (e) {
        throw InvoiceStateActivated(
          invoice: event.invoice,
          exception: e,
          key: const Uuid().v4(),
        );
      }
    });

    on<InvoiceEventRemoveItem>((event, emit) {
      try {
        //COPY
        Invoice invoice = event.invoice;

        //MODIFY PRODUCT LIST
        for (var i = 0; i < invoice.products.length; i++) {
          if (invoice.products[i].productID == event.productID) {
            if (invoice.products[i].quantity > 0) {
              //IF EXISTS AND QTY IS MORE THAN 0, REPLACE WITH THE SAME DATA, EXCEPT QTY - 1
              invoice.products[i] = InvoiceItem(
                quantity: invoice.products[i].quantity - 1,
                productID: invoice.products[i].productID,
                discount: invoice.products[i].discount,
              );

              emit(InvoiceStateActivated(
                invoice: invoice,
                key: const Uuid().v4(),
              ));
              break;

            //TODO: FIGURE OUT WHAT'S WRONG HERE, AND REMOVE THE INSTANCE (NOT THE SHADOW INSTANCE!)
            } else {
              //IF EXISTS AND QTY IS 0, REMOVE INSTANCE
              print("remove instance");
              invoice.products.remove(invoice.products[i]);

              emit(InvoiceStateActivated(
                invoice: invoice,
                key: const Uuid().v4(),
              ));
              break;
            }
          } else if (invoice.products[i].productID != event.productID) {
            break;
          }
        }
      } on Exception catch (e) {
        throw InvoiceStateActivated(
          invoice: event.invoice,
          exception: e,
          key: const Uuid().v4(),
        );
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

        emit(InvoiceStateActivated(invoice: invoice, key: const Uuid().v4()));
      } on Exception catch (e) {
        //? THE ERROR WILL MAINTAIN PREVIOUS INVOICE STATE AS WELL THE EXCEPTION
        throw InvoiceStateActivated(
          invoice: event.invoice,
          exception: e,
          key: const Uuid().v4(),
        );
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

        emit(InvoiceStateActivated(invoice: invoice, key: const Uuid().v4()));
      } on Exception catch (e) {
        throw InvoiceStateActivated(
          invoice: event.invoice,
          exception: e,
          key: const Uuid().v4(),
        );
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
