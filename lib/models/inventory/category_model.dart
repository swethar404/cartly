class CategoryModel {
  final int? categoryId;
  final String categoryName;

  const CategoryModel({
    this.categoryId,
    required this.categoryName,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryId: map['category_id'],
      categoryName: map['category_name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'category_id': categoryId,
      'category_name': categoryName,
    };
  }

  CategoryModel copyWith({
    int? categoryId,
    String? categoryName,
  }) {
    return CategoryModel(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
    );
  }
}