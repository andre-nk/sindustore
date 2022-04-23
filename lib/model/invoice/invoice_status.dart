enum InvoiceStatus { pending, loan, paid, cancelled, hold, returned }

class InvoiceStatusWrapper {
  final InvoiceStatus role;
  const InvoiceStatusWrapper({required this.role});

  static InvoiceStatus get pending => InvoiceStatus.pending;
  static InvoiceStatus get loan => InvoiceStatus.loan;
  static InvoiceStatus get paid => InvoiceStatus.paid;
  static InvoiceStatus get cancelled => InvoiceStatus.cancelled;
  static InvoiceStatus get hold => InvoiceStatus.hold;
  static InvoiceStatus get returned => InvoiceStatus.returned;

  factory InvoiceStatusWrapper.fromCode(String code) {
    switch (code) {
      case "pending":
        return const InvoiceStatusWrapper(role: InvoiceStatus.pending);
      case "loan":
        return const InvoiceStatusWrapper(role: InvoiceStatus.loan);
      case "paid":
        return const InvoiceStatusWrapper(role: InvoiceStatus.paid);
      case "cancelled":
        return const InvoiceStatusWrapper(role: InvoiceStatus.cancelled);
      case "hold":
        return const InvoiceStatusWrapper(role: InvoiceStatus.hold);
      case "returned":
        return const InvoiceStatusWrapper(role: InvoiceStatus.returned);
      default:
        return const InvoiceStatusWrapper(role: InvoiceStatus.pending);
    }
  }
}
