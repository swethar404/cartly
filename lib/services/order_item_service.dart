import '../models/sales/order_item_model.dart';
import '../repositories/order_item_repository.dart';

class OrderItemService {
  OrderItemService._();

  static final OrderItemService instance =
  OrderItemService._();

  final OrderItemRepository _repository =
      OrderItemRepository.instance;

  Future<int> addItem(OrderItemModel item) async {
    return await _repository.addItem(item);
  }

  Future<List<OrderItemModel>> getItems(
      int orderId) async {
    return await _repository.getItems(orderId);
  }
}