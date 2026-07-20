import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'database_tables.dart';
import 'seed_database.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(
      databasePath,
      DatabaseTables.databaseName,
    );

    return await openDatabase(
      path,
      version: DatabaseTables.databaseVersion,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(
      Database db,
      int version,
      ) async {
    // ================= USERS =================

    await db.execute('''
    CREATE TABLE ${DatabaseTables.users}(
      ${DatabaseTables.userId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DatabaseTables.employeeId} TEXT,
      ${DatabaseTables.name} TEXT NOT NULL,
      ${DatabaseTables.email} TEXT UNIQUE,
      ${DatabaseTables.phone} TEXT,
      ${DatabaseTables.password} TEXT NOT NULL,
      ${DatabaseTables.role} TEXT NOT NULL,
      ${DatabaseTables.createdAt} TEXT
    )
    ''');

    // ================= CATEGORIES =================

    await db.execute('''
    CREATE TABLE ${DatabaseTables.categories}(
      ${DatabaseTables.categoryId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DatabaseTables.categoryName} TEXT NOT NULL
    )
    ''');

    // ================= SUPPLIERS =================

    await db.execute('''
    CREATE TABLE ${DatabaseTables.suppliers}(
      ${DatabaseTables.supplierId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DatabaseTables.supplierName} TEXT,
      ${DatabaseTables.supplierPhone} TEXT,
      ${DatabaseTables.supplierEmail} TEXT
    )
    ''');

    // ================= PRODUCTS =================

    await db.execute('''
    CREATE TABLE ${DatabaseTables.products}(
      ${DatabaseTables.productId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DatabaseTables.productName} TEXT,
      ${DatabaseTables.sku} TEXT,
      ${DatabaseTables.barcode} TEXT,
      ${DatabaseTables.category} TEXT,
      ${DatabaseTables.supplier} TEXT,
      ${DatabaseTables.purchasePrice} REAL,
      ${DatabaseTables.sellingPrice} REAL,
      ${DatabaseTables.stock} INTEGER,
      ${DatabaseTables.lowStock} INTEGER,
      ${DatabaseTables.expiryDate} TEXT,
      ${DatabaseTables.image} TEXT
    )
    ''');

    // ================= ORDERS =================

    await db.execute('''
    CREATE TABLE ${DatabaseTables.orders}(
      ${DatabaseTables.orderId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DatabaseTables.orderNumber} TEXT NOT NULL,
      ${DatabaseTables.orderDate} TEXT NOT NULL,
      ${DatabaseTables.subtotal} REAL NOT NULL,
      ${DatabaseTables.discount} REAL NOT NULL,
      ${DatabaseTables.total} REAL NOT NULL,
      ${DatabaseTables.paymentMethod} TEXT NOT NULL
    )
    ''');

    // ================= ORDER ITEMS =================

    await db.execute('''
    CREATE TABLE ${DatabaseTables.orderItems}(
      ${DatabaseTables.itemId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DatabaseTables.orderId} INTEGER NOT NULL,
      ${DatabaseTables.productId} INTEGER NOT NULL,
      ${DatabaseTables.productName} TEXT NOT NULL,
      ${DatabaseTables.quantity} INTEGER NOT NULL,
      ${DatabaseTables.price} REAL NOT NULL,
      ${DatabaseTables.total} REAL NOT NULL
    )
    ''');

    // ================= NOTIFICATIONS =================

    await db.execute('''
    CREATE TABLE ${DatabaseTables.notifications}(
      ${DatabaseTables.notificationId} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${DatabaseTables.userId} INTEGER,
      ${DatabaseTables.title} TEXT,
      ${DatabaseTables.message} TEXT,
      ${DatabaseTables.isRead} INTEGER
    )
    ''');

    await SeedDatabase.seed(db);
  }
}