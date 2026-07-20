import 'package:flutter/material.dart';

import '../models/auth/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService.instance;

  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // ================= ADMIN LOGIN =================

  Future<bool> adminLogin({
    required String employeeId,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    final user = await _authService.adminLogin(
      employeeId: employeeId,
      password: password,
    );

    _isLoading = false;

    if (user != null) {
      _currentUser = user;
      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }

  // ================= CUSTOMER LOGIN =================

  Future<bool> customerLogin({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    final user = await _authService.customerLogin(
      email: email,
      password: password,
    );

    _isLoading = false;

    if (user != null) {
      _currentUser = user;
      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }

  // ================= REGISTER =================

  Future<bool> register(UserModel user) async {
    _isLoading = true;
    notifyListeners();

    final success = await _authService.register(user);

    _isLoading = false;
    notifyListeners();

    return success;
  }

  // ================= LOGOUT =================

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}