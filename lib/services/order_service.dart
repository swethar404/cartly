import '../models/sales/order_model.dart';
import '../repositories/order_repository.dart';

class OrderService {
  OrderService._();

  static final OrderService instance = OrderService._();

  final OrderRepository _repository =
      OrderRepository.instance;

  Future<int> addOrder(OrderModel order) async {
    return await _repository.addOrder(order);
  }

  Future<List<OrderModel>> getOrders() async {
    return await _repository.getOrders();
  }
}