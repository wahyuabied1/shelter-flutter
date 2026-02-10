import 'dart:async';
import 'dart:io';

import 'package:shelter_super_app/core/dependency_injection/service_locator.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/user_response.dart';
import 'package:shelter_super_app/data/repository/auth_repository.dart';

class EditProfileViewmodel extends ABaseChangeNotifier {
  final _authRepository = serviceLocator.get<AuthRepository>();
  Result<UserResponse?> userResult = const Result.initial();
  Result<UserResponse?> updateResult = const Result.initial();
  User? updatedUser;

  void init() {
    getUser();
  }

  Future<void> getUser() async {
    _authRepository.getUser().then((data) {
      userResult = Result.success(data);
      updatedUser = userResult.dataOrNull?.user;
      notifyListeners();
    }, onError: (error) {
      userResult = Result.error(error);
      notifyListeners();
    });
  }

  /// Upload foto ke server
  Future<bool> updatePhoto(File? imageFile) async {
    if (imageFile == null) return false;

    try {
      final response = await _authRepository.changeAvatar(imageFile: imageFile);
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (_) {
      return false;
    }
  }

  Future<bool> changeProfile() {
    if (updatedUser != null) {
      return Result.callApi<User>(
        future: _authRepository.changeProfile(
          user: updatedUser!,
        ),
        onResult: (result) {
          if (result.isSuccess) {
            updateResult = Result.success(updateResult.dataOrNull);
            // Save session dengan updatedUser (data lokal yang lengkap)
            // BUKAN result.dataOrNull (API response yang bisa incomplete)
            _authRepository.saveSession(
              user: userResult.dataOrNull?.copyWith(user: updatedUser),
            );
            getUser();
          } else if (result.isError) {
            updateResult = Result.error(result.error);
          }
          notifyListeners();
        },
      );
    }
    return Future.value(false);
  }

  void onChangeName(String name) {
    updatedUser = updatedUser?.copyWith(nama: name);
  }

  void onChangeUsername(String username) {
    updatedUser = updatedUser?.copyWith(username: username);
  }

  void onChangeEmail(String email) {
    updatedUser = updatedUser?.copyWith(email: email);
  }

  void onChangeAddress(String address) {
    updatedUser = updatedUser?.copyWith(alamat: address);
  }

  /// Refresh session dari server (seperti login ulang tapi tanpa logout)
  /// Untuk mendapatkan data terbaru termasuk foto URL baru
  Future<void> refreshSession() async {
    try {
      final response = await _authRepository.refreshToken();
      if (response.data != null) {
        await _authRepository.saveSession(user: response.data);
        await getUser();
      }
    } catch (_) {}
  }
}
