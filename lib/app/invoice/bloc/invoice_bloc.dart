import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sindu_store/model/invoice/invoice.dart';
import 'package:sindu_store/model/invoice/invoice_item.dart';
import 'package:sindu_store/model/invoice/invoice_status.dart';
import 'package:sindu_store/repository/invoice/invoice_repository.dart';
import 'package:uuid/uuid.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  InvoiceBloc(InvoiceRepository invoiceRepository) : super(const InvoiceStateInitial()) {
    on<InvoiceEventActivate>((event, emit) async {
      try {
        final Invoice invoice = Invoice(
          adminHandlerUID: _firebaseAuth.currentUser!.uid,
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
          int targetIndex = invoice.products
              .indexWhere((element) => element.productID == event.productID);

          //EXIST
          if (targetIndex >= 0) {
            invoice.products[targetIndex] = InvoiceItem(
              quantity: invoice.products[targetIndex].quantity + 1,
              productID: invoice.products[targetIndex].productID,
              discount: invoice.products[targetIndex].discount,
            );

            emit(InvoiceStateActivated(
              invoice: invoice,
              key: const Uuid().v4(),
            ));

            //DOESN'T EXIST
          } else {
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
          }
        } else {
          final Invoice newInvoiceModel = Invoice(
            adminHandlerUID: invoice.adminHandlerUID,
            customerName: event.invoice.customerName,
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

        //MODIFY PRODUCT LIST
        if (event.invoice.products.isNotEmpty) {
          int targetIndex = invoice.products
              .indexWhere((element) => element.productID == event.productID);

          //EXIST
          if (targetIndex >= 0) {
            invoice.products[targetIndex] = InvoiceItem(
              quantity: invoice.products[targetIndex].quantity,
              productID: invoice.products[targetIndex].productID,
              discount: event.productDiscount,
            );

            emit(InvoiceStateActivated(
              invoice: invoice,
              key: const Uuid().v4(),
            ));

            //DOESN'T EXIST
          } else {
            invoice.products.add(
              InvoiceItem(
                quantity: 1,
                productID: event.productID,
                discount: event.productDiscount,
              ),
            );

            emit(InvoiceStateActivated(
              invoice: invoice,
              key: const Uuid().v4(),
            ));
          }
        } else {
          final Invoice newInvoiceModel = Invoice(
            adminHandlerUID: invoice.adminHandlerUID,
            customerName: event.invoice.customerName,
            products: [
              InvoiceItem(
                quantity: 1,
                productID: event.productID,
                discount: event.productDiscount,
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

    on<InvoiceEventMarkStatus>((event, emit) {
      try {
        final Invoice updatedInvoice = Invoice(
            adminHandlerUID: event.invoice.adminHandlerUID,
            customerName: event.invoice.customerName,
            products: event.invoice.products,
            status: event.status,
            createdAt: event.invoice.createdAt,
            updatedAt: event.invoice.updatedAt,
          );

        emit(InvoiceStateActivated(invoice: updatedInvoice, key: const Uuid().v4()));
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

    on<InvoiceEventCreate>((event, emit) async {
      try {
        await invoiceRepository.createInvoice(invoice: event.invoice);
        emit(InvoiceStateCreated());
      } on Exception catch (e) {
        emit(InvoiceStateFailed(exception: e));
      }
    });

    on<InvoiceEventUpdate>((event, emit) async {
      try {
        await invoiceRepository.updateInvoice(
          invoice: event.invoice,
          invoiceUID: event.invoiceUID,
        );
        emit(InvoiceStateCreated());
      } on Exception catch (e) {
        emit(InvoiceStateFailed(exception: e));
      }
    });

    on<InvoiceEventUpdateCustomerName>((event, emit) {
      try {
        final Invoice updatedInvoice = Invoice(
            adminHandlerUID: event.invoice.adminHandlerUID,
            customerName: event.newCustomerName,
            products: event.invoice.products,
            status: event.invoice.status,
            createdAt: event.invoice.createdAt,
            updatedAt: event.invoice.updatedAt,
          );

        emit(InvoiceStateActivated(invoice: updatedInvoice, key: const Uuid().v4()));
      } on Exception catch (e) {
        emit(InvoiceStateFailed(exception: e));
      }
    });

    on<InvoiceEventDelete>((event, emit) async {
      try {
        await invoiceRepository.deleteInvoice(invoiceUID: event.invoiceUID);
        emit(state);
      } on Exception catch (e) {
        emit(InvoiceStateFailed(exception: e));
      }
    });

    on<InvoiceEventFetchQuery>((event, emit) async {
      try {
        emit(InvoiceStateQueryFetching());
        final Query<Invoice> query = await invoiceRepository.fetchInvoiceQuery();
        emit(InvoiceStateQueryLoaded(query: query));
      } on Exception catch (e) {
        emit(InvoiceStateFailed(exception: e));
      }
    });
  }
}
