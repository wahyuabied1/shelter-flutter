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

  /// Upload foto ke server dan update local storage
  Future<bool> updatePhoto(File? imageFile) async {
    if (imageFile == null) return false;

    // Upload foto baru ke server
    return Result.callApi<User>(
      future: _authRepository.changeAvatar(
        imageFile: imageFile,
      ),
      onResult: (result) async {
        if (result.isSuccess) {
          // KUNCI: Ambil current session
          final currentSession = userResult.dataOrNull;
          final updatedUserWithNewPhoto = result.dataOrNull;

          print('🔍 DEBUG UPDATE PHOTO:');
          print('  API Response - updatedUserWithNewPhoto:');
          print('     id: ${updatedUserWithNewPhoto?.id}');
          print('     nama: ${updatedUserWithNewPhoto?.nama}');
          print('     email: ${updatedUserWithNewPhoto?.email}');
          print('     foto: ${updatedUserWithNewPhoto?.foto}');
          print('  currentSession: ${currentSession != null ? "ADA" : "NULL"}');
          print('  token: ${currentSession?.token ?? "NULL"}');
          print('  updatedUserWithNewPhoto: ${updatedUserWithNewPhoto != null ? "ADA" : "NULL"}');

          // Update session dengan user baru, KEEP token dan menus lama
          if (currentSession != null &&
              updatedUserWithNewPhoto != null &&
              currentSession.token != null &&  // ✅ Pastikan token ada
              currentSession.token!.isNotEmpty) {

            // Create UserResponse baru dengan token & menus lama, user baru
            final updatedSession = UserResponse(
              token: currentSession.token,  // ✅ KEEP token lama
              user: updatedUserWithNewPhoto,  // ✅ User baru dari response
              menus: currentSession.menus,  // ✅ KEEP menus lama
            );

            print('  ✅ AKAN SAVE SESSION dengan token: ${updatedSession.token}');
            await _authRepository.saveSession(user: updatedSession);
            print('  ✅ SAVE SESSION SELESAI');

            // Refresh user data dari local storage (sudah diupdate)
            await getUser();
            print('  ✅ GET USER SELESAI - userResult: ${userResult.dataOrNull?.user?.nama}');
          } else {
            print('  ❌ SKIP SAVE SESSION - Validation gagal!');
            print('     currentSession null? ${currentSession == null}');
            print('     updatedUser null? ${updatedUserWithNewPhoto == null}');
            print('     token null/empty? ${currentSession?.token == null || currentSession!.token!.isEmpty}');
          }
        }
        notifyListeners();
      },
    );
  }

  Future<bool> changeProfile() {
    if (updatedUser != null) {
      return Result.callApi<User>(
        future: _authRepository.changeProfile(
          user: updatedUser!,
        ),
        onResult: (result) async {
          if (result.isSuccess) {
            updateResult = Result.success(updateResult.dataOrNull);

            // KUNCI: Ambil current session
            final currentSession = userResult.dataOrNull;
            final updatedUserFromServer = result.dataOrNull;

            print('🔍 DEBUG CHANGE PROFILE:');
            print('  API Response - updatedUserFromServer:');
            print('     id: ${updatedUserFromServer?.id}');
            print('     nama: ${updatedUserFromServer?.nama}');
            print('     email: ${updatedUserFromServer?.email}');
            print('     foto: ${updatedUserFromServer?.foto}');
            print('  currentSession: ${currentSession != null ? "ADA" : "NULL"}');
            print('  token: ${currentSession?.token ?? "NULL"}');
            print('  updatedUserFromServer: ${updatedUserFromServer != null ? "ADA" : "NULL"}');

            // Update session dengan user baru, KEEP token dan menus lama
            if (currentSession != null &&
                updatedUserFromServer != null &&
                currentSession.token != null &&  // ✅ Pastikan token ada
                currentSession.token!.isNotEmpty) {

              // Create UserResponse baru dengan token & menus lama, user baru
              final updatedSession = UserResponse(
                token: currentSession.token,  // ✅ KEEP token lama
                user: updatedUserFromServer,  // ✅ User baru dari response
                menus: currentSession.menus,  // ✅ KEEP menus lama
              );

              print('  ✅ AKAN SAVE SESSION dengan token: ${updatedSession.token}');
              await _authRepository.saveSession(user: updatedSession);
              print('  ✅ SAVE SESSION SELESAI');

              // Refresh user data dari local storage (sudah diupdate)
              await getUser();
              print('  ✅ GET USER SELESAI - userResult: ${userResult.dataOrNull?.user?.nama}');
            } else {
              print('  ❌ SKIP SAVE SESSION - Validation gagal!');
              print('     currentSession null? ${currentSession == null}');
              print('     updatedUser null? ${updatedUserFromServer == null}');
              print('     token null/empty? ${currentSession?.token == null || currentSession!.token!.isEmpty}');
            }
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
