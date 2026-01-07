import 'package:flutter/material.dart';
import 'package:shelter_super_app/core/basic_extensions/result_extensions.dart';
import 'package:shelter_super_app/core/dependency_injection/service_locator.dart';
import 'package:shelter_super_app/core/network/repository/core_http_repository.dart';
import 'package:shelter_super_app/core/network/response/api_response.dart';
import 'package:shelter_super_app/core/routing/core/a_router.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/core/utils/string_utils.dart';
import 'package:shelter_super_app/data/model/change_password_response.dart';
import 'package:shelter_super_app/data/model/user_response.dart';
import 'package:shelter_super_app/data/repository/auth_repository.dart';

class ChangePasswordViewmodel extends ABaseChangeNotifier {
  final _authRepository = serviceLocator.get<AuthRepository>();
  final coreHttpRepo = serviceLocator.get<CoreHttpRepository>();

  String oldPass = '';
  String newPass = '';
  String confirmPass = '';
  UserResponse? userResult;
  Result<ChangePasswordReponse?> changeResult = const Result.initial();

  init() {
    getUser();
  }

  Future<void> getUser() async {
    _authRepository.getUser().then((data) {
      userResult = data;
      notifyListeners();
    }, onError: (error) {});
  }

  onChangeOldPass(String pass) {
    oldPass = pass;
    notifyListeners();
  }

  onChangeNewPass(String pass) {
    newPass = pass;
    notifyListeners();
  }

  onChangeConfirmPass(String pass) {
    confirmPass = pass;
    notifyListeners();
  }

  Future<bool> changePassword() {
    return Result.callApi<ChangePasswordReponse>(
      future: _authRepository.changePassword(
        oldPassword: oldPass,
        password: newPass,
        passwordConfirmation: confirmPass,
      ),
      onResult: (result) {
        if (result.isSuccess) {
          if(userResult!=null){
            coreHttpRepo.setUser(userResult!.copyWith(token: result.dataOrNull?.newToken));
          }
          changeResult = Result.success(result.dataOrNull);
        } else if (result.isError) {
          changeResult = Result.error(result.error);
        }
      },
    );
  }
}
