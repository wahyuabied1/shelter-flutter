import 'dart:async';

import 'package:flutter/widgets.dart';
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

  Future<bool> updatePhoto(Image? image){
    return Future.value(false);
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
}
