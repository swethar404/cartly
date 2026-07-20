import '../core/helpers/password_helper.dart';
import '../database/database_service.dart';
import '../database/database_tables.dart';
import '../models/auth/user_model.dart';

class AuthRepository {
  AuthRepository._();

  static final AuthRepository instance = AuthRepository._();

  final DatabaseService _database = DatabaseService.instance;

  // ================= REGISTER CUSTOMER =================

  Future<bool> register(UserModel user) async {
    final existing = await _database.query(
      DatabaseTables.users,
      where: "${DatabaseTables.email} = ?",
      whereArgs: [user.email],
    );

    if (existing.isNotEmpty) {
      return false;
    }

    final newUser = user.copyWith(
      password: PasswordHelper.hashPassword(user.password),
    );

    await _database.insert(
      DatabaseTables.users,
      newUser.toMap(),
    );

    return true;
  }

  // ================= ADMIN LOGIN =================

  Future<UserModel?> adminLogin({
    required String employeeId,
    required String password,
  }) async {
    final result = await _database.query(
      DatabaseTables.users,
      where:
      "${DatabaseTables.employeeId} = ? AND ${DatabaseTables.role} = ?",
      whereArgs: [
        employeeId,
        "owner",
      ],
    );

    if (result.isEmpty) {
      return null;
    }

    final user = UserModel.fromMap(result.first);

    final valid = PasswordHelper.verifyPassword(
      password: password,
      hashedPassword: user.password,
    );

    if (!valid) {
      return null;
    }

    return user;
  }

  // ================= CUSTOMER LOGIN =================

  Future<UserModel?> customerLogin({
    required String email,
    required String password,
  }) async {
    final result = await _database.query(
      DatabaseTables.users,
      where:
      "${DatabaseTables.email} = ? AND ${DatabaseTables.role} = ?",
      whereArgs: [
        email,
        "customer",
      ],
    );

    if (result.isEmpty) {
      return null;
    }

    final user = UserModel.fromMap(result.first);

    final valid = PasswordHelper.verifyPassword(
      password: password,
      hashedPassword: user.password,
    );

    if (!valid) {
      return null;
    }

    return user;
  }

  // ================= GET USER =================

  Future<UserModel?> getUser(int userId) async {
    final result = await _database.getById(
      DatabaseTables.users,
      DatabaseTables.userId,
      userId,
    );

    if (result == null) {
      return null;
    }

    return UserModel.fromMap(result);
  }
}