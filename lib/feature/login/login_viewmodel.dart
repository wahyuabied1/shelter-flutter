import 'package:flutter/material.dart';
import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/basic_extensions/result_extensions.dart';
import 'package:shelter_super_app/core/network/response/scalar_response.dart';
import 'package:shelter_super_app/core/routing/core/a_router.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/user_response.dart';
import 'package:shelter_super_app/data/repository/auth_repository.dart';

class LoginViewModel extends ABaseChangeNotifier {
  final _authRepository = serviceLocator.get<AuthRepository>();

  Result<UserResponse?> loginResult = const Result.initial();

  Future<bool> login(String username, String password) {
    return Result.callApi<ScalarResponse>(
      future: _authRepository.login(
        username: username,
        password: password,
      ),
      onResult: (result) {
        if (result.isSuccess) {
          loginResult = Result.success(
            UserResponse(
              user: User.fromJson(result.dataOrNull?.jsonBody?['user']),
              menus: Menus.fromJson(result.dataOrNull?.jsonBody?['menus']),
              token: result.dataOrNull?.jsonBody?['token'],
            ),
          );
          _authRepository.saveSession(user: loginResult.dataOrNull);

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
