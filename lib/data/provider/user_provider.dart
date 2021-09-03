import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/data/models/app_user.dart';
import 'package:todo_list/data/models/user_registration.dart';
import 'package:todo_list/data/remote/firebase_auth.dart';
import 'package:todo_list/data/remote/firebase_database.dart';
import 'package:todo_list/data/remote/firebase_storage.dart';
import 'package:todo_list/data/remote/response.dart';
import 'package:todo_list/util/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  final FirebaseAuthSource _authSource = FirebaseAuthSource();
  final FirebaseStorageSource _storageSource = FirebaseStorageSource();
  final FirebaseDatabase _databaseSource = FirebaseDatabase();

  bool isLoading = false;
  late AppUser _user;

  Future<AppUser> get user => _getUser();

  Future<Response> loginUser(String email, String password,
      GlobalKey<ScaffoldState> errorScaffoldKey) async {
    Response<dynamic> response = await _authSource.signIn(email, password);
    if (response is Success<UserCredential>) {
      String id = response.value.user!.uid;
      SharedPreferencesUtil.setUserId(id);
    } else if (response is Error) {
      //print(response.message)
    }
    return response;
  }

  Future<Response> registerUser(UserRegistration userRegistration,
      GlobalKey<ScaffoldState> errorScaffoldKey) async {
    Response<dynamic> response = await _authSource.register(
        userRegistration.email, userRegistration.password);
    if (response is Success<UserCredential>) {
      String id = (response as Success<UserCredential>).value.user!.uid;
      response = await _storageSource.uploadUserProfilePhoto(
          userRegistration.localProfilePhotoPath, id);

      if (response is Success<String>) {
        String profilePhotoUrl = response.value;
        AppUser user = AppUser(
            id: id,
            name: userRegistration.name,
            age: userRegistration.age,
            profilePhotoPath: profilePhotoUrl);
        _databaseSource.addUser(user);
        SharedPreferencesUtil.setUserId(id);
        _user = user;
        return Response.success(user);
      }
    }
    if (response is Error); //print(response.message)
    return response;
  }

  Future<AppUser> _getUser() async {
    if (_user != null) return _user;
    String id = await SharedPreferencesUtil.getUserId();
    _user = AppUser.fromSnapshot(await _databaseSource.getUser(id));
    return _user;
  }

  void updateUserProfilePhoto(
      String localFilePath, GlobalKey<ScaffoldState> errorScaffoldKey) async {
    isLoading = true;
    notifyListeners();
    Response<dynamic> response =
        await _storageSource.uploadUserProfilePhoto(localFilePath, _user.id);
    isLoading = false;
    if (response is Success<String>) {
      _user.profilePhotoPath = response.value;
      _databaseSource.updateUser(_user);
    } else if (response is Error) {
      //print(response.message)
    }
    notifyListeners();
  }
}
