import '../models/inventory/category_model.dart';
import '../repositories/category_repository.dart';

class CategoryService {
  CategoryService._();

  static final CategoryService instance =
  CategoryService._();

  final CategoryRepository _repository =
      CategoryRepository.instance;

  Future<List<CategoryModel>> getCategories() async {
    return await _repository.getCategories();
  }

  Future<int> addCategory(CategoryModel category) async {
    return await _repository.addCategory(category);
  }

  Future<int> updateCategory(CategoryModel category) async {
    return await _repository.updateCategory(category);
  }

  Future<int> deleteCategory(int id) async {
    return await _repository.deleteCategory(id);
  }
}