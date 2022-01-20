part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object> get props => [status];
}

class TokenExpiredChanged extends AuthenticationEvent {
  const TokenExpiredChanged(this.tokenStatus);

  final TokenStatus tokenStatus;

  @override
  List<Object> get props => [tokenStatus];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
