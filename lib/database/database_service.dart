import 'package:sqflite/sqflite.dart';

import 'database_helper.dart';

class DatabaseService {
  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();

  Future<Database> get _db async =>
      await DatabaseHelper.instance.database;

  // ================= INSERT =================

  Future<int> insert(
      String table,
      Map<String, dynamic> values,
      ) async {
    final db = await _db;

    return await db.insert(table, values);
  }

  // ================= UPDATE =================

  Future<int> update(
      String table,
      Map<String, dynamic> values,
      String where,
      List<Object?> whereArgs,
      ) async {
    final db = await _db;

    return await db.update(
      table,
      values,
      where: where,
      whereArgs: whereArgs,
    );
  }

  // ================= DELETE =================

  Future<int> delete(
      String table,
      String where,
      List<Object?> whereArgs,
      ) async {
    final db = await _db;

    return await db.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  // ================= GET ALL =================

  Future<List<Map<String, dynamic>>> getAll(
      String table,
      ) async {
    final db = await _db;

    return await db.query(table);
  }

  // ================= GET BY ID =================

  Future<Map<String, dynamic>?> getById(
      String table,
      String idColumn,
      dynamic id,
      ) async {
    final db = await _db;

    final result = await db.query(
      table,
      where: '$idColumn = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }

  // ================= QUERY =================

  Future<List<Map<String, dynamic>>> query(
      String table, {
        String? where,
        List<Object?>? whereArgs,
        String? orderBy,
      }) async {
    final db = await _db;

    return await db.query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
    );
  }

  // ================= RAW QUERY =================

  Future<List<Map<String, dynamic>>> rawQuery(
      String sql, [
        List<Object?>? arguments,
      ]) async {
    final db = await _db;

    return await db.rawQuery(sql, arguments);
  }

  // ================= CLEAR TABLE =================

  Future<void> clearTable(
      String table,
      ) async {
    final db = await _db;

    await db.delete(table);
  }
}