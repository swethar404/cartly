import '../database/database_service.dart';
import '../database/database_tables.dart';
import '../models/inventory/category_model.dart';

class CategoryRepository {
  CategoryRepository._();

  static final CategoryRepository instance =
  CategoryRepository._();

  final DatabaseService _database = DatabaseService.instance;

  // ================= GET ALL =================

  Future<List<CategoryModel>> getCategories() async {
    final result = await _database.query(
      DatabaseTables.categories,
    );

    return result
        .map((e) => CategoryModel.fromMap(e))
        .toList();
  }

  // ================= ADD =================

  Future<int> addCategory(CategoryModel category) async {
    return await _database.insert(
      DatabaseTables.categories,
      category.toMap(),
    );
  }

  // ================= UPDATE =================

  Future<int> updateCategory(CategoryModel category) async {
    return await _database.update(
      DatabaseTables.categories,
      category.toMap(),
      DatabaseTables.categoryId,
      category.categoryId!,
    );
  }

  // ================= DELETE =================

  Future<int> deleteCategory(int id) async {
    return await _database.delete(
      DatabaseTables.categories,
      DatabaseTables.categoryId,
      id,
    );
  }
}