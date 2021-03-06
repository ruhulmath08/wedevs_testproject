import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedevs_testproject/authentication/login_handler.dart';
import 'package:wedevs_testproject/authentication/token_handler.dart';
import 'package:wedevs_testproject/constants/enum.dart';
import 'package:wedevs_testproject/constants/share_preferences_constant.dart';
import 'package:wedevs_testproject/local_storage/shared_preferences/wedevs_test_project_sharePreferences.dart';
import 'package:wedevs_testproject/models/user_model.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  StreamSubscription<AuthenticationStatus>? _authenticationStatusSubscription;
  AuthenticationBloc() : super(const AuthenticationState.unknown()) {
    _authenticationStatusSubscription = LoginHandler().status.listen(
          (status) => add(AuthenticationStatusChanged(status)),
        );
    TokenHandler().status.listen((status) {
      if (status == TokenStatus.expired) {
        add(TokenExpiredChanged(status));
      }
    });
  }

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      LoginHandler.logOut();
    } else if (event is TokenExpiredChanged) {
      LoginHandler.logOut();
    }
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return const AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
        final String? jsonData = WeDevsTestProjectSharePreferences.getString(key: spUserModel);
        final Map<String, dynamic> map = json.decode(jsonData!) as Map<String, dynamic>;
        final UserModel userModel = UserModel.fromJson(map);
        return userModel.token != null ? AuthenticationState.authenticated(userModel) : const AuthenticationState.unauthenticated();
      default:
        return const AuthenticationState.unknown();
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription?.cancel();
    return super.close();
  }
}
