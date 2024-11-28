import 'package:aviz/Feature/Authentication/data/repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthRegiserUser>(
      (event, emit) async {
        emit(AuthLoding());
        final result = await _authRepository.registerUser(
          username: event.username,
          name: event.name,
          password: event.password,
          passwordConfirm: event.passwordConfirm,
          phone: event.phone,
        );
        emit(AuthResponse(result));
      },
    );
    on<AuthLoginUser>(
      (event, emit) async {
        emit(AuthLoding());
        final result = await _authRepository.loginUser(
          event.username,
          event.password,
        );
        emit(AuthResponse(result));
      },
    );
  }
}
