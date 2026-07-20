import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/inventory/supplier_model.dart';
import '../../../providers/supplier_provider.dart';

class SuppliersScreen extends StatefulWidget {
  const SuppliersScreen({super.key});

  @override
  State<SuppliersScreen> createState() => _SuppliersScreenState();
}

class _SuppliersScreenState extends State<SuppliersScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<SupplierProvider>().loadSuppliers();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> showSupplierDialog({
    SupplierModel? supplier,
  }) async {
    if (supplier != null) {
      nameController.text = supplier.supplierName;
      phoneController.text = supplier.supplierPhone;
      emailController.text = supplier.supplierEmail;
    } else {
      nameController.clear();
      phoneController.clear();
      emailController.clear();
    }

    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            supplier == null
                ? "Add Supplier"
                : "Edit Supplier",
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Supplier Name",
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "Phone",
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text(
                supplier == null ? "Save" : "Update",
              ),
              onPressed: () async {
                final newSupplier = SupplierModel(
                  supplierId: supplier?.supplierId,
                  supplierName: nameController.text.trim(),
                  supplierPhone: phoneController.text.trim(),
                  supplierEmail: emailController.text.trim(),
                );

                if (supplier == null) {
                  await context
                      .read<SupplierProvider>()
                      .addSupplier(newSupplier);
                } else {
                  await context
                      .read<SupplierProvider>()
                      .updateSupplier(newSupplier);
                }

                if (!mounted) return;

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SupplierProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Suppliers"),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => showSupplierDialog(),
        child: const Icon(Icons.add),
      ),

      body: provider.loading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : provider.suppliers.isEmpty
          ? const Center(
        child: Text("No Suppliers Found"),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: provider.suppliers.length,
        itemBuilder: (context, index) {
          final supplier =
          provider.suppliers[index];

          return Card(
            margin:
            const EdgeInsets.only(bottom: 15),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                Colors.blue.shade100,
                child: const Icon(
                  Icons.local_shipping,
                  color: Colors.blue,
                ),
              ),
              title: Text(
                supplier.supplierName,
              ),
              subtitle: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    supplier.supplierPhone,
                  ),
                  Text(
                    supplier.supplierEmail,
                  ),
                ],
              ),
              trailing: PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == "edit") {
                    showSupplierDialog(
                      supplier: supplier,
                    );
                  }

                  if (value == "delete") {
                    await provider.deleteSupplier(
                      supplier.supplierId!,
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