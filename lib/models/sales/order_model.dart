class OrderModel {
  final int? orderId;
  final String orderNumber;
  final String orderDate;
  final double subtotal;
  final double discount;
  final double total;
  final String paymentMethod;

  const OrderModel({
    this.orderId,
    required this.orderNumber,
    required this.orderDate,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.paymentMethod,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['order_id'],
      orderNumber: map['order_number'],
      orderDate: map['order_date'],
      subtotal: map['subtotal'],
      discount: map['discount'],
      total: map['total'],
      paymentMethod: map['payment_method'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'order_id': orderId,
      'order_number': orderNumber,
      'order_date': orderDate,
      'subtotal': subtotal,
      'discount': discount,
      'total': total,
      'payment_method': paymentMethod,
    };
  }
}