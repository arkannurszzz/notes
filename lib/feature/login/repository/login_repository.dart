import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:notes/domain/repository.dart';
import 'package:notes/feature/login/model/login_response.dart';
import 'package:notes/domain/model/reponse_login_api.dart';

class LoginRepository extends Repository {
  Future<LoginResponse> login(String username, String password) async {
    try {
      final ReponseLoginApi response = await dioServices.post(
        '/ops/auth/signin',
        data: {'username': username, 'password': password},
      );
      debugPrint('🟢 [LOGIN dadada]');
      debugPrint(const JsonEncoder.withIndent('  ').convert(response.toJson()));

      // Pastikan code == 200 dan success == true
      if (response.code == 200 && (response.success ?? false)) {
        return LoginResponse(
          token: response.data['token'],
          message: response.message,
          data: response.data,
          success: response.success,
        );
      } else {
        // Ambil message dari response kalau ada
        final message = response.message ?? 'Login gagal, coba lagi.';
        Get.snackbar('Info', message, snackPosition: SnackPosition.BOTTOM);
        return LoginResponse(); // return kosong biar gak null
      }
    } catch (e) {
      // Tangkap error dari Dio atau parsing
      Get.snackbar(
        'Error',
        'Terjadi kesalahan: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return LoginResponse();
    }
  }
}
