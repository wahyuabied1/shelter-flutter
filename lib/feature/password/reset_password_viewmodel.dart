import 'package:flutter/material.dart';
import 'package:shelter_super_app/core/dependency_injection/service_locator.dart';
import 'package:shelter_super_app/core/routing/core/a_router.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/string_utils.dart';
import 'package:shelter_super_app/data/repository/auth_repository.dart';

class ResetPasswordViewmodel extends ABaseChangeNotifier {
  final _authRepository = serviceLocator.get<AuthRepository>();

  String _email = '';
  String get email => _email;

  bool get isEnableButton => _email.isValidEmail;

  void onChangeEmail(String email) {
    _email = email;
    notifyListeners();
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