import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:flower/repositories/auth_repository.dart';  // Ensure you have the correct repository

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthLoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final token = await authRepository.login(event.email, event.password);  // Calls the login API
        emit(AuthAuthenticated(token: token));
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    on<AuthRegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.register(event.email, event.password);  // Calls the register API
        emit(AuthInitial());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    on<AuthLogoutRequested>((event, emit) {
      emit(AuthInitial());
    });
  }
}
