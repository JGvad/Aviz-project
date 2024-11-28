part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoding extends AuthState {}

final class AuthResponse extends AuthState {
  final Either<String, String> result;
  AuthResponse(this.result);
}
