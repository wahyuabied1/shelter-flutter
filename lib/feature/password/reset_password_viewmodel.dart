import 'package:flutter/material.dart';
import 'package:shelter_super_app/core/basic_extensions/result_extensions.dart';
import 'package:shelter_super_app/core/dependency_injection/service_locator.dart';
import 'package:shelter_super_app/core/network/response/api_response.dart';
import 'package:shelter_super_app/core/routing/core/a_router.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/core/utils/string_utils.dart';
import 'package:shelter_super_app/data/repository/auth_repository.dart';

class ResetPasswordViewmodel extends ABaseChangeNotifier {
  final _authRepository = serviceLocator.get<AuthRepository>();

  String _email = '';
  String get email => _email;
  bool get isEnableButton => _email.isValidEmail;
  Result<ApiResponse?> resetPassResult = const Result.initial();

  void onChangeEmail(String email) {
    _email = email;
    notifyListeners();
  }

  Future<bool> resetPassword() {
    return Result.callApi<ApiResponse>(
      future: _authRepository.resetPasword(email: email),
      onResult: (result) {
        if (result.isSuccess) {
          resetPassResult = Result.success(result.dataOrNull);
        } else if (result.isError) {
          showDefaultError(result.getErrorMessage());
        }
      },
    );
  }

  void showDefaultError(String errorMessage) {
    final aRouter = serviceLocator<ARouter>();
    ScaffoldMessenger.of(aRouter.rootSheelNavigatorKey.currentContext!)
        .showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(errorMessage),
      ),
    );
  }
}