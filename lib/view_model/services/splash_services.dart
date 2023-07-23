// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserData() => UserViewModel().getUser();
  void authenticateUser(BuildContext context) async {
    getUserData().then((value) async {
      debugPrint(value.token);
      if (value.token == "null" || value.token!.isEmpty) {
        await Future.delayed(const Duration(seconds: 3));

        Navigator.pushNamed(context, RoutesName.login);
      } else {
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.home);
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
    });
  }
}
