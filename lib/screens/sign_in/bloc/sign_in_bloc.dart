import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart';
import 'package:wedevs_testproject/models/user_model.dart';
import 'package:wedevs_testproject/networks/api_endpoints.dart';
import 'package:wedevs_testproject/networks/http_helper.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState());
  final HttpHelper _helper = HttpHelper();

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignInEmailChanged) {
      yield _mapSignInEmailChangedToState(event, state);
    } else if (event is SignInPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is SignInSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }

  SignInState _mapSignInEmailChangedToState(
    SignInEmailChanged event,
    SignInState state,
  ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([email]),
    );
  }

  SignInState _mapPasswordChangedToState(
    SignInPasswordChanged event,
    SignInState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password]),
    );
  }

  Stream<SignInState> _mapLoginSubmittedToState(
    SignInSubmitted event,
    SignInState state,
  ) async* {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    if (state.status.isValidated) {
      final _url = ApiEndpoints.getLoginUrl();
      final String password = state.password.value;
      final String email = state.email.value;
      final Response response = await _helper.postParamsData(url: _url, username: email, password: password);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseJson = json.decode(response.body) as Map<String, dynamic>;
        final UserModel userModel = UserModel.fromJson(responseJson);

        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } else {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    } else {
      yield state.copyWith(status: FormzStatus.submissionFailure);
    }
  }
}
