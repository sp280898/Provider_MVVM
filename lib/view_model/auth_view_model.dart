import 'package:flutter/material.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';
import 'user_view_model.dart';

class AuthViewModel extends ChangeNotifier {
  final _myRepo = AuthRepository();
  bool _loading = false;
  bool get loading => _loading;
  bool get signUploading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
  // signUploading(bool value) {
  //   _loading = value;
  //   notifyListeners();
  // }

  Future<void> loginApi(dynamic body, BuildContext context) async {
    setLoading(true);
    _myRepo.loginApi(body).then((value) {
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      setLoading(false);
      // UserViewModel().saveUser(value);
      userPreference.saveUser(
        UserModel(token: value['token']),
      );
      Utils.flushBarErrorMessage(
          'Successfully logged In', context, Colors.green);
      // Utils.snackBar('Successfully logged In', context);
      Navigator.pushNamed(context, RoutesName.home);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage('$error', context, Colors.red);
    });
  }

  Future<void> signUpApi(dynamic body, BuildContext context) async {
    setLoading(true);
    _myRepo.signUpApi(body).then((value) {
      setLoading(false);
      Navigator.pushNamed(context, RoutesName.home);
      Utils.flushBarErrorMessage(
          'SignedUp Successfully', context, Colors.green);
      // Utils.snackBar('Successfully logged In', context);
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage('$error', context, Colors.red);
    });
  }
}
