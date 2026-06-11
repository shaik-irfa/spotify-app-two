import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

class AuthState {
  final bool isLoading;
  final String? error;

  const AuthState({this.isLoading = false, this.error});

  AuthState copyWith({bool? isLoading, String? error}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  final AuthService _service = AuthService();

  Future<bool> login(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _service.login(username: username, password: password);

      if (result["success"]) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("jwt_token", result["token"]);
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          error: result["message"],
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "An unexpected error occurred: ${e.toString()}",
      );
      return false;
    }
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());
