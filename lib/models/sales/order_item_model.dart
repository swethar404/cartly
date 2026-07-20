class OrderItemModel {
  final int? itemId;
  final int orderId;
  final int productId;
  final String productName;
  final int quantity;
  final double price;
  final double total;

  const OrderItemModel({
    this.itemId,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.total,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      itemId: map['item_id'],
      orderId: map['order_id'],
      productId: map['product_id'],
      productName: map['product_name'],
      quantity: map['quantity'],
      price: map['price'],
      total: map['total'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'item_id': itemId,
      'order_id': orderId,
      'product_id': productId,
      'product_name': productName,
      'quantity': quantity,
      'price': price,
      'total': total,
    };
  }
}