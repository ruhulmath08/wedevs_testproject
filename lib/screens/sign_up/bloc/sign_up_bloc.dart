import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart';
import 'package:wedevs_testproject/models/user_register_model.dart';
import 'package:wedevs_testproject/networks/api_endpoints.dart';
import 'package:wedevs_testproject/networks/http_helper.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState());
  final HttpHelper _helper = HttpHelper();

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpNameChanged) {
      yield _mapNameChangedToState(event, state);
    } else if (event is SignUpPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is SignUpEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is SignUpSubmitted) {
      yield* _mapSignUpSubmittedToState(event, state);
    }
  }

  SignUpState _mapNameChangedToState(
    SignUpNameChanged event,
    SignUpState state,
  ) {
    final name = Name.dirty(event.name);
    return state.copyWith(
      name: name,
      status: Formz.validate([name]),
    );
  }

  SignUpState _mapPasswordChangedToState(
    SignUpPasswordChanged event,
    SignUpState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password]),
    );
  }

  SignUpState _mapEmailChangedToState(
    SignUpEmailChanged event,
    SignUpState state,
  ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([email]),
    );
  }

  Stream<SignUpState> _mapSignUpSubmittedToState(
    SignUpSubmitted event,
    SignUpState state,
  ) async* {
    yield state.copyWith(status: FormzStatus.submissionInProgress);
    if (state.status.isValidated) {
      final _url = ApiEndpoints.getRegistrationUrl();
      final headers = {'Content-Type': 'application/json'};
      final UserRegisterModel userRegisterModel = UserRegisterModel();
      userRegisterModel.username = state.name.value;
      userRegisterModel.email = state.email.value;
      userRegisterModel.password = state.password.value;

      //final String body = {'username': username, 'email': email, 'password': password};
      // final String body = jsonEncode(<String, String>{
      //   'username': username,
      //   'email': email,
      //   'password': password,
      // });

      final Response? response = await _helper.postData(url: _url, header: headers, body: userRegisterModel.toJson());
      if (response?.statusCode == 200) {
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } else if (response?.statusCode == 400) {
        String errorMessage;
        try {
          final Map<String, dynamic> responseJson = json.decode(response!.body) as Map<String, dynamic>;
          errorMessage = responseJson['message'].toString();
        } catch (e) {
          errorMessage = 'Login failed, please try again';
        }
        yield state.copyWith(
          status: FormzStatus.submissionFailure,
          submissionStatusMessage: errorMessage,
        );
      } else if (response?.statusCode == 500) {
        yield state.copyWith(
          status: FormzStatus.submissionFailure,
          submissionStatusMessage: 'Internal server error',
        );
      } else {
        yield state.copyWith(
          status: FormzStatus.submissionFailure,
          submissionStatusMessage: 'Something wrong! please try again',
        );
      }
    }
  }
}
