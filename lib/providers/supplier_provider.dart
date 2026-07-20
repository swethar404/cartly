import 'package:flutter/material.dart';

import '../models/inventory/supplier_model.dart';
import '../services/supplier_service.dart';

class SupplierProvider extends ChangeNotifier {
  final SupplierService _service =
      SupplierService.instance;

  List<SupplierModel> _suppliers = [];

  List<SupplierModel> get suppliers => _suppliers;

  bool _loading = false;

  bool get loading => _loading;

  Future<void> loadSuppliers() async {
    _loading = true;
    notifyListeners();

    _suppliers = await _service.getSuppliers();

    _loading = false;
    notifyListeners();
  }

  Future<void> addSupplier(
      SupplierModel supplier) async {
    await _service.addSupplier(supplier);
    await loadSuppliers();
  }

  Future<void> updateSupplier(
      SupplierModel supplier) async {
    await _service.updateSupplier(supplier);
    await loadSuppliers();
  }

  Future<void> deleteSupplier(int id) async {
    await _service.deleteSupplier(id);
    await loadSuppliers();
  }
}