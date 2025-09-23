class LoginState {
  final bool isLoading;
  final String? error;

  const LoginState({
    this.isLoading = false,
    this.error,
  });

  factory LoginState.initial() {
    return const LoginState(isLoading: false, error: null);
  }

  LoginState copyWith({bool? isLoading, String? error}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
