import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/feature/home/view/home_view.dart';
import 'package:notes/feature/login/repository/login_repository.dart';

class LoginController extends GetxController {
  final LoginRepository loginRepository = LoginRepository();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isPasswordHidden = true.obs;
  RxBool rememberMe = false.obs;
  RxBool isLoading = false.obs; // Tambahan untuk loading state

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.toggle();
  }

  void toggleRememberMe() {
    rememberMe.toggle();
  }

  void forgotPassword() {
    Get.snackbar(
      'Info',
      'Fitur lupa password akan segera hadir',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    // Validasi input
    if (username.isEmpty) {
      _showError('Username tidak boleh kosong');
      return;
    }

    if (password.isEmpty) {
      _showError('Password tidak boleh kosong');
      return;
    }

    // Jalankan login dengan loading state
    isLoading.value = true;

    try {
      final result = await loginRepository.login(username, password);

      debugPrint('🟢 [LOGIN RESULT]');
      debugPrint(const JsonEncoder.withIndent('  ').convert(result.toJson()));

      if (result.message == 'Login berhasil' || result.success == true) {
        Get.offAll(() => const HomeView());
      } else {
        _showError(result.message ?? 'Login gagal, periksa kembali data Anda.');
      }
    } catch (e) {
      _showError('Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
