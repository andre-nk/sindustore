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
          adminHandlerUID: "",
          customerName: "",
          products: const [],
          status: InvoiceStatus.pending,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

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
        if (event.invoice.products.isNotEmpty) {
          for (var i = 0; i < invoice.products.length; i++) {
            if (invoice.products[i].productID == event.productID) {
              //"IF EXISTS, REPLACE WITH THE SAME DATA, EXCEPT QTY + 1");
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
              final Invoice newInvoiceModel = Invoice(
                adminHandlerUID: invoice.adminHandlerUID,
                customerName: invoice.adminHandlerUID,
                products: [
                  ...invoice.products,
                  InvoiceItem(
                    quantity: 1,
                    productID: event.productID,
                    discount: 0.0,
                  ),
                ],
                status: invoice.status,
                createdAt: invoice.createdAt,
                updatedAt: DateTime.now(),
              );

              emit(InvoiceStateActivated(
                invoice: newInvoiceModel,
                key: const Uuid().v4(),
              ));
              break;
            }
          }
        } else {
          final Invoice newInvoiceModel = Invoice(
            adminHandlerUID: invoice.adminHandlerUID,
            customerName: invoice.adminHandlerUID,
            products: [
              InvoiceItem(
                quantity: 1,
                productID: event.productID,
                discount: 0.0,
              ),
            ],
            status: invoice.status,
            createdAt: invoice.createdAt,
            updatedAt: DateTime.now(),
          );

          emit(InvoiceStateActivated(
            invoice: newInvoiceModel,
            key: const Uuid().v4(),
          ));
        }
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
            if (invoice.products[i].quantity > 1) {
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
            } else if (invoice.products[i].quantity <= 1) {
              invoice.products.remove(invoice.products[i]);
              emit(InvoiceStateActivated(
                invoice: invoice,
                key: const Uuid().v4(),
              ));
              break;
            }
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
        emit(const InvoiceStateInitial());
      } on Exception catch (e) {
        throw InvoiceStateInitial(exception: e);
      }
    }));
  }
}
