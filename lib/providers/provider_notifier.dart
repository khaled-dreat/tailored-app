import 'package:tailored/model/user.dart';
import 'package:flutter/material.dart';

class Provider_control with ChangeNotifier {
  String local = 'ar';
  String Currancy = '';
  User user = User();

  Provider_control(this.local);

  String logo = '';
  int Plan_index = 1;
  int countCart = 0;
  bool isLogin = false;
  getlocal() => local;
  getPlan_index() => Plan_index;

  setLogin(bool isLog) {
    isLogin = isLog;
    notifyListeners();
  }

  setUser(User u) {
    user = u;
    notifyListeners();
  }

  intcnt(int st) {
    Plan_index = st;
    notifyListeners();
  }

  intcountCart(int st) {
    this.countCart = st;
    notifyListeners();
  }

  setLocal(String st) {
    local = st;
    notifyListeners();
  }

  setCurrancy(String currancy) {
    Currancy = currancy;
    notifyListeners();
  }
}
