part of '../widgets.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class InvoiceCard extends StatelessWidget {
  const InvoiceCard(
      {Key? key, required this.invoice, required this.index, required this.invoiceUID})
      : super(key: key);

  final Invoice invoice;
  final String invoiceUID;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey[900]!.withOpacity(0.05),
            spreadRadius: 10,
            blurRadius: 15,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border.all(
          color: AppTheme.colors.outline,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        onLongPress: () {
          showDialog(
            context: context,
            builder: (innerContext) {
              return InvoiceDeleteModal(
                invoiceUID: invoiceUID,
                ancestorContext: context,
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0).copyWith(bottom: 12.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nota - 0" + index.toString(),
                        style:
                            AppTheme.text.paragraph.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          DateFormat.Hm().format(invoice.createdAt) +
                              ", " +
                              DateFormat.yMd().format(invoice.createdAt),
                          style: AppTheme.text.footnote,
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: AppTheme.colors.tertiary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                    ),
                    child: Text(
                      invoice.status.name.capitalize(),
                      style: AppTheme.text.footnote.copyWith(color: Colors.white),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Divider(
                  color: AppTheme.colors.outline,
                ),
              ),
              InvoiceCardItemList(invoice: invoice),
              InvoiceCardValue(
                invoice: invoice,
                invoiceUID: invoiceUID,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
