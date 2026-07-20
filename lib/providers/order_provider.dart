import 'package:flutter/material.dart';

import '../models/sales/order_item_model.dart';
import '../models/sales/order_model.dart';
import '../services/order_item_service.dart';
import '../services/order_service.dart';

class OrderProvider extends ChangeNotifier {
  final OrderService _orderService = OrderService.instance;
  final OrderItemService _itemService = OrderItemService.instance;

  List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  bool _loading = false;

  bool get loading => _loading;

  // ================= LOAD ORDERS =================

  Future<void> loadOrders() async {
    _loading = true;
    notifyListeners();

    _orders = await _orderService.getOrders();

    _loading = false;
    notifyListeners();
  }

  // ================= ADD ORDER =================

  Future<int> addOrder(OrderModel order) async {
    final orderId = await _orderService.addOrder(order);

    await loadOrders();

    return orderId;
  }

  // ================= ADD ORDER ITEM =================

  Future<void> addOrderItem(OrderItemModel item) async {
    await _itemService.addItem(item);
  }

  // ================= GET ORDER ITEMS =================

  Future<List<OrderItemModel>> getItems(int orderId) async {
    return await _itemService.getItems(orderId);
  }
}