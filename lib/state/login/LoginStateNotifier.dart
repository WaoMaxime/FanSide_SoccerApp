import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/api_service.dart';
import 'LoginState.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  final ApiService apiService;

  LoginNotifier({required this.apiService}) : super(LoginState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // TODO: Replace this with your actual API login call
      await Future.delayed(const Duration(seconds: 2));

      if (email == "test@test.com" && password == "123456") {
        state = state.copyWith(isLoading: false);
      } else {
        state = state.copyWith(
          isLoading: false,
          error: "Invalid email or password",
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
