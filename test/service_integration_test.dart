// ignore_for_file: avoid_print
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_app_two/services/auth_service.dart';
import 'package:spotify_app_two/services/home_service.dart';
import 'package:spotify_app_two/utils/helpers.dart';

void main() {
  // Allow real HTTP network requests in tests
  setUpAll(() {
    // SharedPreferences requires mock values during Flutter widget/unit testing
    SharedPreferences.setMockInitialValues({});
  });

  group('Live API Integration Verification', () {
    test('Login and Data Fetch Integration Flow', () async {
      final authService = AuthService();
      final homeService = HomeService();

      print('Step 1: Dispatching Login Request...');
      final loginResult = await authService.login(
        username: 'rahul',
        password: 'rahul@2021',
      );

      print('Login Success Status: ${loginResult["success"]}');
      if (!loginResult["success"]) {
        print('Login Error: ${loginResult["message"]}');
      }
      
      expect(loginResult["success"], true);
      expect(loginResult["token"], isNotNull);
      print('JWT Token Received: ${loginResult["token"]}');

      print('Step 2: Storing JWT Token in SharedPreferences...');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jwt_token', loginResult["token"]);

      // Verify token is correctly written
      final storedToken = prefs.getString('jwt_token');
      expect(storedToken, loginResult["token"]);
      print('Token successfully stored and verified in SharedPreferences!');

      print('Step 3: Fetching Auth Headers...');
      final headers = await getAuthHeaders();
      expect(headers['Authorization'], 'Bearer $storedToken');
      print('Auth headers generated successfully: ${headers["Authorization"]}');

      print('Step 4: Fetching Featured Playlists...');
      final playlists = await homeService.getFeaturedPlaylists();
      print('Featured Playlists Count: ${playlists.length}');
      expect(playlists, isNotNull);

      print('Step 5: Fetching Categories...');
      final categories = await homeService.getCategories();
      print('Categories Count: ${categories.length}');
      expect(categories, isNotNull);

      print('Step 6: Fetching New Releases...');
      final newReleases = await homeService.getNewReleases();
      print('New Releases Count: ${newReleases.length}');
      expect(newReleases, isNotNull);

      print('Verification Summary: Auth flow, token storage, and API data fetching succeeded!');
    });
  });
}
