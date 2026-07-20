import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/inventory/category_model.dart';
import '../../../providers/category_provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final TextEditingController categoryController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CategoryProvider>().loadCategories();
    });
  }

  @override
  void dispose() {
    categoryController.dispose();
    super.dispose();
  }

  Future<void> addCategory() async {
    if (categoryController.text.trim().isEmpty) return;

    await context.read<CategoryProvider>().addCategory(
      CategoryModel(
        categoryName: categoryController.text.trim(),
      ),
    );

    categoryController.clear();

    if (!mounted) return;

    Navigator.pop(context);
  }

  Future<void> showAddDialog() async {
    categoryController.clear();

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Add Category"),

          content: TextField(
            controller: categoryController,
            decoration: const InputDecoration(
              hintText: "Category Name",
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: addCategory,
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> showEditDialog(CategoryModel category) async {
    categoryController.text = category.categoryName;

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Edit Category"),

          content: TextField(
            controller: categoryController,
            decoration: const InputDecoration(
              hintText: "Category Name",
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () async {
                await context
                    .read<CategoryProvider>()
                    .updateCategory(
                  CategoryModel(
                    categoryId: category.categoryId,
                    categoryName:
                    categoryController.text.trim(),
                  ),
                );

                if (!mounted) return;

                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CategoryProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: showAddDialog,
        child: const Icon(Icons.add),
      ),

      body: provider.loading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : provider.categories.isEmpty
          ? const Center(
        child: Text(
          "No Categories",
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: provider.categories.length,
        itemBuilder: (context, index) {
          final category =
          provider.categories[index];

          return Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                Colors.deepOrange.shade100,
                child: const Icon(
                  Icons.category,
                  color: Colors.deepOrange,
                ),
              ),

              title: Text(
                category.categoryName,
              ),

              trailing: PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == "edit") {
                    showEditDialog(category);
                  }

                  if (value == "delete") {
                    await provider.deleteCategory(
                      category.categoryId!,
                    );
                  }
                },

                itemBuilder: (_) => const [
                  PopupMenuItem(
                    value: "edit",
                    child: Text("Edit"),
                  ),
                  PopupMenuItem(
                    value: "delete",
                    child: Text("Delete"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}