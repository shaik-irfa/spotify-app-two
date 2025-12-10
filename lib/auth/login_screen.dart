import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../home/home_screen.dart';
import '../provider/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://wallpaperaccess.com/full/8711379.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.55),
          ),

          Center(
            child: Container(
              width: 330,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.75),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.graphic_eq, size: 50, color: Colors.green),
                  const SizedBox(height: 16),
                  const Text(
                    "Spotify Remix",
                    style: TextStyle(
                      color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 28),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("USERNAME", style: TextStyle(color: Colors.white70)),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: usernameController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Enter username",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                  const SizedBox(height: 18),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("PASSWORD", style: TextStyle(color: Colors.white70)),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: passwordController,
                    obscureText: !showPassword,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Enter password",
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: Icon(
                          showPassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.black87,
                        ),
                        onPressed: () =>
                            setState(() => showPassword = !showPassword),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                    ),
                  ),
                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: authState.isLoading
                          ? null
                          : () async {
                              final ok = await ref
                                  .read(authProvider.notifier)
                                  .login(
                                    usernameController.text.trim(),
                                    passwordController.text.trim(),
                                  );

                              if (ok && mounted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: authState.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("LOGIN",
                              style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),

                  if (authState.error != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      authState.error!,
                      style: const TextStyle(color: Colors.redAccent, fontSize: 13),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
