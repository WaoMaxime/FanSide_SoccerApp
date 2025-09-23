import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'LoginState.dart';
import '../../data/repositories/AuthRepository.dart';

class LoginStateNotifier extends StateNotifier<LoginState> {
  final AuthRepository _authRepository;

  LoginStateNotifier(this._authRepository) : super(const LoginState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _authRepository.signInWithEmail(email, password);
      state = state.copyWith(isLoading: false, error: null);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message ?? "Login failed");
    }
  }

  Future<void> signUp(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _authRepository.signUpWithEmail(email, password);
      state = state.copyWith(isLoading: false, error: null);
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false, error: e.message ?? "Sign up failed");
    }
  }

  void reset() {
    state = LoginState.initial();
  }

  Future<void> logout() async {
    await _authRepository.signOut();
  }
}

