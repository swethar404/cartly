import '../models/auth/user_model.dart';
import '../repositories/auth_repository.dart';

class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  final AuthRepository _repository = AuthRepository.instance;

  // ================= REGISTER =================

  Future<bool> register(UserModel user) async {
    return await _repository.register(user);
  }

  // ================= ADMIN LOGIN =================

  Future<UserModel?> adminLogin({
    required String employeeId,
    required String password,
  }) async {
    return await _repository.adminLogin(
      employeeId: employeeId,
      password: password,
    );
  }

  // ================= CUSTOMER LOGIN =================

  Future<UserModel?> customerLogin({
    required String email,
    required String password,
  }) async {
    return await _repository.customerLogin(
      email: email,
      password: password,
    );
  }

  // ================= GET USER =================

  Future<UserModel?> getUser(int userId) async {
    return await _repository.getUser(userId);
  }
}