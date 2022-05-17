enum InvoiceStatus { pending, paid }

class InvoiceStatusWrapper {
  final InvoiceStatus role;
  const InvoiceStatusWrapper({required this.role});

  static InvoiceStatus get pending => InvoiceStatus.pending;
  static InvoiceStatus get paid => InvoiceStatus.paid;

  factory InvoiceStatusWrapper.fromCode(String code) {
    switch (code) {
      case "pending":
        return const InvoiceStatusWrapper(role: InvoiceStatus.pending);
      case "paid":
        return const InvoiceStatusWrapper(role: InvoiceStatus.paid);
      default:
        return const InvoiceStatusWrapper(role: InvoiceStatus.pending);
    }
  }
}
