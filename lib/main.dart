import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/login_screen.dart';
import 'home/home_screen.dart';
import 'screens/loading_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Spotify Remix",
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: "Roboto",
      ),
      home: const RootAuthChecker(),
    );
  }
}

class RootAuthChecker extends StatefulWidget {
  const RootAuthChecker({super.key});

  @override
  State<RootAuthChecker> createState() => _RootAuthCheckerState();
}

class _RootAuthCheckerState extends State<RootAuthChecker> {
  bool? _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("jwt_token");
    setState(() {
      _isLoggedIn = token != null && token.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoggedIn == null) {
      return const LoadingScreen();
    }
    return _isLoggedIn! ? const HomeScreen() : const LoginScreen();
  }
}
