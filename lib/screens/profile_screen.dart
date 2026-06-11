// import 'package:flutter/material.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   bool isEditing = false;
//   TextEditingController nameCtrl = TextEditingController(text: "Shaik Irfan");
//   TextEditingController emailCtrl = TextEditingController(text: "irfan@example.com");

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF111111),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF111111),
//         elevation: 0,
//         leading: const BackButton(color: Colors.white),
//         centerTitle: true,
//         title: const Text(
//           "Profile",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 22),
//         child: Column(
//           children: [
//             const SizedBox(height: 30),
//             Center(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(70),
//                 child: Image.network(
//                   "https://cdn-icons-png.flaticon.com/512/456/456212.png",
//                   height: 120,
//                   width: 120,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 22),
//             TextField(
//               controller: nameCtrl,
//               enabled: isEditing,
//               style: const TextStyle(color: Colors.white, fontSize: 18),
//               decoration: const InputDecoration(
//                 labelText: "Name",
//                 labelStyle: TextStyle(color: Colors.white70),
//                 enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white38)),
//                 focusedBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.green)),
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               controller: emailCtrl,
//               enabled: false,
//               style: const TextStyle(color: Colors.white70, fontSize: 16),
//               decoration: const InputDecoration(
//                 labelText: "Email",
//                 labelStyle: TextStyle(color: Colors.white70),
//                 enabledBorder: UnderlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white38)),
//               ),
//             ),
//             const SizedBox(height: 45),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (isEditing) {
//                     // Save logic (local only)
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text("Profile saved successfully!"),
//                         backgroundColor: Colors.green,
//                       ),
//                     );
//                   }
//                   setState(() => isEditing = !isEditing);
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.green,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                 ),
//                 child: Text(
//                   isEditing ? "Save" : "Edit Profile",
//                   style: const TextStyle(fontSize: 17, color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login_screen.dart';
import '../widgets/music_image.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;

  const ProfileScreen({
    super.key,
    required this.username,
    required this.email,
  });

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');

    if (!context.mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111111),
        elevation: 0,
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Profile Picture
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: const Color(0xFF1A1A1A),
                child: ClipOval(
                  child: MusicImage(
                    imageUrl: "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // Username
            Text(
              username,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),

            // Email
            Text(
              email,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white.withValues(alpha: 0.75),
              ),
            ),

            const SizedBox(height: 30),

            // Divider
            Container(height: 1, color: Colors.white24),
            const SizedBox(height: 25),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => logout(context),
                child: const Text(
                  "LOG OUT",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
