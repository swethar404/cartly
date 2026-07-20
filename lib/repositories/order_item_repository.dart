import '../database/database_service.dart';
import '../database/database_tables.dart';
import '../models/sales/order_item_model.dart';

class OrderItemRepository {
  OrderItemRepository._();

  static final OrderItemRepository instance =
  OrderItemRepository._();

  final DatabaseService _database =
      DatabaseService.instance;

  Future<int> addItem(OrderItemModel item) async {
    return await _database.insert(
      DatabaseTables.orderItems,
      item.toMap(),
    );
  }

  Future<List<OrderItemModel>> getItems(
      int orderId) async {
    final result = await _database.query(
      DatabaseTables.orderItems,
      where: "${DatabaseTables.orderId} = ?",
      whereArgs: [orderId],
    );

    return result
        .map((e) => OrderItemModel.fromMap(e))
        .toList();
  }
}