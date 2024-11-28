part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class AuthRegiserUser extends AuthEvent {
  final String username;
  final String name;
  final String password;
  final String passwordConfirm;
  final String phone;
  AuthRegiserUser({
    required this.username,
    required this.name,
    required this.password,
    required this.passwordConfirm,
    required this.phone,
  });
}

final class AuthLoginUser extends AuthEvent {
  final String username;
  final String password;
  AuthLoginUser({
    required this.username,
    required this.password,
  });
}
