import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:wedevs_testproject/constants/enum.dart';
import 'package:wedevs_testproject/constants/share_preferences_constant.dart';
import 'package:wedevs_testproject/local_storage/shared_preferences/wedevs_test_project_sharePreferences.dart';
import 'package:wedevs_testproject/models/user_model.dart';

class LoginHandler {
  static final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    final token = WeDevsTestProjectSharePreferences.getString(key: spToken);
    if (token != null) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }

    yield* _controller.stream;
  }

  static Future<void> loginSuccess({@required UserModel? userModel}) async {
    assert(userModel != null);
    _controller.add(AuthenticationStatus.authenticated);
  }

  static Future<void> logOut() async {
    WeDevsTestProjectSharePreferences.clear();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
