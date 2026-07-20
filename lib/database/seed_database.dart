import 'package:sqflite/sqflite.dart';

import '../core/helpers/password_helper.dart';
import 'database_tables.dart';

class SeedDatabase {
  SeedDatabase._();

  static Future<void> seed(Database db) async {
    // ================= DEFAULT OWNER =================

    await db.insert(
      DatabaseTables.users,
      {
        DatabaseTables.employeeId: "ADM001",
        DatabaseTables.name: "Store Owner",
        DatabaseTables.email: "admin@cartly.com",
        DatabaseTables.phone: "9999999999",
        DatabaseTables.password:
        PasswordHelper.hashPassword("cartly@admin"),
        DatabaseTables.role: "owner",
        DatabaseTables.createdAt:
        DateTime.now().toIso8601String(),
      },
    );

    // ================= DEFAULT CATEGORIES =================

    final categories = [
      "Groceries",
      "Beverages",
      "Snacks",
      "Personal Care",
      "Household",
      "Electronics",
      "Stationery",
      "Fashion",
    ];

    for (final category in categories) {
      await db.insert(
        DatabaseTables.categories,
        {
          DatabaseTables.categoryName: category,
        },
      );
    }
  }
}