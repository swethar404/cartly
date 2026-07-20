import '../models/inventory/supplier_model.dart';
import '../repositories/supplier_repository.dart';

class SupplierService {
  SupplierService._();

  static final SupplierService instance =
  SupplierService._();

  final SupplierRepository _repository =
      SupplierRepository.instance;

  Future<List<SupplierModel>> getSuppliers() async {
    return await _repository.getSuppliers();
  }

  Future<int> addSupplier(SupplierModel supplier) async {
    return await _repository.addSupplier(supplier);
  }

  Future<int> updateSupplier(SupplierModel supplier) async {
    return await _repository.updateSupplier(supplier);
  }

  Future<int> deleteSupplier(int id) async {
    return await _repository.deleteSupplier(id);
  }
}