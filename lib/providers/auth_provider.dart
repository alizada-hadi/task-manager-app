import "package:flutter/material.dart";
import "../services/auth_services.dart";
import "../models/User.dart";

class AuthProvider with ChangeNotifier {
  final AuthServices _authServices = AuthServices();
  User? _user;

  User? get user => _user;

  Future<void> initialize() async {
    _user = await _authServices.getCurrentUser();
    notifyListeners();
  }

  Future<void> signUp(String name, String email, String password) async {
    await _authServices.signUpWithEmail(name, email, password);
    _user = await _authServices.loginWithEmail(email, password);
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    _user = await _authServices.loginWithEmail(email, password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authServices.logout();
    _user = null;
    notifyListeners();
  }
}
