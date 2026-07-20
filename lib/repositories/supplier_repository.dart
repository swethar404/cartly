import '../database/database_service.dart';
import '../database/database_tables.dart';
import '../models/inventory/supplier_model.dart';

class SupplierRepository {
  SupplierRepository._();

  static final SupplierRepository instance =
  SupplierRepository._();

  final DatabaseService _database = DatabaseService.instance;

  Future<List<SupplierModel>> getSuppliers() async {
    final result = await _database.query(
      DatabaseTables.suppliers,
    );

    return result
        .map((e) => SupplierModel.fromMap(e))
        .toList();
  }

  Future<int> addSupplier(SupplierModel supplier) async {
    return await _database.insert(
      DatabaseTables.suppliers,
      supplier.toMap(),
    );
  }

  Future<int> updateSupplier(SupplierModel supplier) async {
    return await _database.update(
      DatabaseTables.suppliers,
      supplier.toMap(),
      DatabaseTables.supplierId,
      supplier.supplierId!,
    );
  }

  Future<int> deleteSupplier(int id) async {
    return await _database.delete(
      DatabaseTables.suppliers,
      DatabaseTables.supplierId,
      id,
    );
  }
}