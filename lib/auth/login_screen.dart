import 'dart:ui';
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
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  final List<String> albumCovers = const [
    "https://images.unsplash.com/photo-1614613535308-eb5fbd3d2c17?w=300&q=80",
    "https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=300&q=80",
    "https://images.unsplash.com/photo-1498038432885-c6f3f1b912ee?w=300&q=80",
    "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=300&q=80",
    "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=300&q=80",
    "https://images.unsplash.com/photo-1506157786151-b8491531f063?w=300&q=80",
    "https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?w=300&q=80",
    "https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=300&q=80",
    "https://images.unsplash.com/photo-1487180142328-054b783fc471?w=300&q=80",
    "https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad?w=300&q=80",
    "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300&q=80",
    "https://images.unsplash.com/photo-1459749411175-04bf5292ceea?w=300&q=80",
  ];

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Tilted Music/Album Covers Collage Background
          Positioned.fill(
            child: OverflowBox(
              maxWidth: MediaQuery.of(context).size.width * 1.4,
              maxHeight: MediaQuery.of(context).size.height * 1.4,
              child: Transform.rotate(
                angle: -0.15,
                child: GridView.builder(
                  padding: const EdgeInsets.all(20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: albumCovers.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(albumCovers[index]),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // 2. High-opacity Premium Dark Gradient Overlay (78% to 88%)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.78),
                    Colors.black.withValues(alpha: 0.88),
                  ],
                ),
              ),
            ),
          ),

          // 3. Responsive Login Card (Frosted Glassmorphism)
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Container(
                    width: 360,
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.07),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.12),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.6),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Spotify Logo / Music Icon
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.green.withValues(alpha: 0.5),
                              width: 1.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.graphic_eq,
                            size: 40,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          "Spotify Remix",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Log in to start listening",
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Username input
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "USERNAME",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: usernameController,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Enter username",
                            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
                            filled: true,
                            fillColor: Colors.black.withValues(alpha: 0.4),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.green, width: 1.5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Password input
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "PASSWORD",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: passwordController,
                          obscureText: !showPassword,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Enter password",
                            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
                            filled: true,
                            fillColor: Colors.black.withValues(alpha: 0.4),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                            suffixIcon: IconButton(
                              icon: Icon(
                                showPassword ? Icons.visibility_off : Icons.visibility,
                                color: Colors.white.withValues(alpha: 0.6),
                              ),
                              onPressed: () =>
                                  setState(() => showPassword = !showPassword),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.green, width: 1.5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),

                        // Login Button
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

                                    if (ok && context.mounted) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              elevation: 8,
                              shadowColor: Colors.green.withValues(alpha: 0.4),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: authState.isLoading
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : const Text(
                                    "LOG IN",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                          ),
                        ),

                        // Error message
                        if (authState.error != null) ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.redAccent.withValues(alpha: 0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.error_outline, size: 16, color: Colors.redAccent),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    authState.error!,
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
