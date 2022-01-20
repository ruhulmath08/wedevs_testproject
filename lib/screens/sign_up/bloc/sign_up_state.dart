part of 'sign_up_bloc.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.status = FormzStatus.pure,
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.submissionStatusMessage = '',
  });

  final FormzStatus status;
  final Name name;
  final Email email;
  final Password password;
  final String submissionStatusMessage;

  SignUpState copyWith({
    FormzStatus? status,
    Name? name,
    Email? email,
    Password? password,
    String? submissionStatusMessage,
  }) {
    return SignUpState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      submissionStatusMessage: submissionStatusMessage ?? this.submissionStatusMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        name,
        email,
        password,
        submissionStatusMessage,
      ];
}

enum NameValidationError { empty }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');

  const Name.dirty([String value = '']) : super.dirty(value);

  @override
  NameValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : NameValidationError.empty;
  }
}

enum EmailValidationError { empty }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');

  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : EmailValidationError.empty;
  }
}

enum PasswordValidationError { empty }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');

  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  PasswordValidationError? validator(String value) {
    return value.isNotEmpty == true ? null : PasswordValidationError.empty;
  }
}
