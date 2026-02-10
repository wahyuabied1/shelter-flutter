import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/network/repository/core_http_repository.dart';
import 'package:intl/intl.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/user_response.dart';
import 'package:shelter_super_app/data/repository/auth_repository.dart';

class ProfileViewmodel extends ABaseChangeNotifier {
  final _authRepository = serviceLocator.get<AuthRepository>();
  final CoreHttpRepository _coreHttpRepository = serviceLocator.get();
  Result<void> logoutResult = const Result.initial();
  Result<UserResponse?> userResult = const Result.initial();

  /// Versi foto, berubah setiap getUser() agar NetworkImage fetch ulang
  int fotoVersion = DateTime.now().millisecondsSinceEpoch;

  void init() {
    getUser();
  }

  Future<void> getUser() async {
    fotoVersion = DateTime.now().millisecondsSinceEpoch;
    _authRepository.getUser().then((data) {
      userResult = Result.success(data);
      notifyListeners();
    }, onError: (error) {
      userResult = Result.error(error);
      notifyListeners();
    });
  }

  Future<void> logout() async {
    return _authRepository.logout().then((data) {
      logoutResult = Result.success({});
      _coreHttpRepository.clear();
      notifyListeners();
    }, onError: (error) {
      logoutResult = Result.error(error);
      notifyListeners();
    });
  }

  String getUserCreatedDate() {
    if (userResult.dataOrNull?.user?.createdAt == null ||
        (userResult.dataOrNull?.user?.createdAt ?? '').isEmpty) {
      return '-';
    }
    try {
      final date =
          DateTime.parse(userResult.dataOrNull!.user!.createdAt!).toLocal();
      return DateFormat('EEEE, dd-MMM-yyyy', 'id_ID').format(date);
    } catch (e) {
      return '-';
    }
  }
  String getUserUpdatedDate() {
    if (userResult.dataOrNull?.user?.updatedAt == null ||
        (userResult.dataOrNull?.user?.updatedAt ?? '').isEmpty) {
      return '-';
    }
    try {
      final date =
      DateTime.parse(userResult.dataOrNull!.user!.updatedAt!).toLocal();
      return DateFormat('EEEE, dd-MMM-yyyy', 'id_ID').format(date);
    } catch (e) {
      return '-';
    }
  }
}
