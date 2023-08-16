import 'package:flutter/material.dart';
import 'package:pawder_use_case/userModel.dart';
import 'package:pawder_use_case/userService.dart';

class HomeProvider extends ChangeNotifier {

  List<UserModel> users = [];

  Future addFirstData() async {
    await addUser(5);

  }

  Future addUser(int k) async {
    for(int i = 0; i < k; i++) {

      UserModel user = await UserService().getRandomUser();

      users.add(user);
    }

    notifyListeners();
  }

  removeUser(UserModel user) {

    users.removeAt(0);

    notifyListeners();
  }

}