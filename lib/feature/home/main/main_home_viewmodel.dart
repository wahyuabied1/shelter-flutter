import 'package:shelter_super_app/app/di/service_locator.dart';
import 'package:shelter_super_app/core/state_management/a_base_change_notifier.dart';
import 'package:shelter_super_app/core/utils/result/result.dart';
import 'package:shelter_super_app/data/model/user_response.dart';
import 'package:shelter_super_app/data/repository/auth_repository.dart';

class MainHomeViewmodel extends ABaseChangeNotifier {
  final _authRepository = serviceLocator.get<AuthRepository>();
  Result<UserResponse?> userResult = const Result.initial();
  String? greeting;

  void init() {
    getUser();
    getTimeOfDayGreeting();
  }

  Future<void> getUser() async {
    _authRepository.getUser().then((data){
      userResult = Result.success(data);
      notifyListeners();
    },onError: (error){
      userResult = Result.error(error);
      notifyListeners();
    });
  }

  void getTimeOfDayGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      greeting = 'Selamat Pagi 👋';
    } else if (hour < 15) {
      greeting = 'Selamat Siang 👋';
    } else if (hour < 18) {
      greeting = 'Selamat Sore 👋';
    } else {
      greeting = 'Selamat Malam 👋';
    }
    notifyListeners();
  }
}
