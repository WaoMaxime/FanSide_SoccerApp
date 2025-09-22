import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'LoginStateNotifier.dart';
import 'LoginState.dart';
import '../../data/services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final loginProvider =
StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return LoginNotifier(apiService: apiService);
});
