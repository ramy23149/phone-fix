enum PaymentMethoudEnum {
  card,
  cash,
}
extension PaymentMethoudExtention on PaymentMethoudEnum {
  String get displayName {
    switch (this) {
      case PaymentMethoudEnum.card:
        return "بطاقة";
      case PaymentMethoudEnum.cash:
        return "كاش";
    }
  }
}