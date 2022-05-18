part of "../widgets.dart";

class CustomFAB extends StatelessWidget {
  const CustomFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SheetsBloc(SheetsRepository()),
      child: BlocBuilder<SheetsBloc, SheetsState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[900]!.withOpacity(0.05),
                  spreadRadius: 5,
                  blurRadius: 10,
                  offset: const Offset(0, -2), // changes position of shadow
                ),
              ],
              border: Border.all(color: Colors.white, width: 4),
              shape: BoxShape.circle,
            ),
            child: FloatingActionButton(
              elevation: 0,
              onPressed: () {
                context.read<SheetsBloc>().add(
                      SheetsEventInsertInvoice(
                        Invoice(
                          adminHandlerUID: "test-admin",
                          customerName: "Supri",
                          products: const [
                            InvoiceItem(
                              quantity: 2,
                              productID: "eff55ac0-b7cb-46e7-9f78-facef7d7c416",
                              discount: -20000,
                            ),
                             InvoiceItem(
                              quantity: 2,
                              productID: "06f784b2-4e30-4282-85df-46cc034b17ba",
                              discount: -15000,
                            )
                          ],
                          status: InvoiceStatus.paid,
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        ),
                      ),
                    );
              },
              child: Icon(
                Ionicons.add,
                color: AppTheme.colors.secondary,
                size: 32,
              ),
              backgroundColor: AppTheme.colors.primary,
            ),
          );
        },
      ),
    );
  }
}
