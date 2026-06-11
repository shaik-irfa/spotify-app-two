// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../provider/home_provider.dart';
// import '../auth/login_screen.dart';
// import '../screens/profile_screen.dart';
// import '../screens/playlist_detail_screen.dart';
// import '../screens/category_playlists_screen.dart';
// import '../screens/album_detail_screen.dart';
// import '../widgets/mini_player.dart';

// class HomeScreen extends ConsumerStatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends ConsumerState<HomeScreen> {
//   bool showMenu = false;

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       ref.read(homeProvider.notifier).fetchHomeData();
//     });
//   }

//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove("jwt_token");
//     if (!mounted) return;
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (_) => const LoginScreen()),
//       (route) => false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final homeState = ref.watch(homeProvider);

//     return Stack(
//       children: [
//         Scaffold(
//           backgroundColor: Colors.black,
//           appBar: AppBar(
//             backgroundColor: Colors.black,
//             elevation: 0,
//             title: Image.network(
//               "https://cdn-icons-png.flaticon.com/512/727/727240.png",
//               height: 26,
//             ),
//             actions: [
//               IconButton(
//                 onPressed: () => setState(() => showMenu = true),
//                 icon: const Icon(Icons.menu, color: Colors.white),
//               ),
//             ],
//           ),
//           body: homeState.isLoading
//               ? const Center(child: CircularProgressIndicator(color: Colors.green))
//               : SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       buildSection(
//                         title: "Editor's picks",
//                         items: homeState.playlists
//                             .map((e) => {
//                                   "id": e.id ?? "",
//                                   "name": e.name ?? "",
//                                   "image": e.imageUrl ?? "",
//                                 })
//                             .take(9)
//                             .toList(),
//                         onTap: (item) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => PlaylistDetailScreen(
//                                 playlistId: item["id"]!,
//                                 playlistName: item["name"]!,
//                                 playlistImageUrl: item["image"]!,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       const SizedBox(height: 24),
//                       buildSection(
//                         title: "Genres & Moods",
//                         items: homeState.categories
//                             .map((e) => {
//                                   "id": e.id ?? "",
//                                   "name": e.name ?? "",
//                                   "image": e.imageUrl ?? "",
//                                 })
//                             .take(9)
//                             .toList(),
//                         onTap: (item) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => CategoryPlaylistsScreen(
//                                 categoryId: item["id"]!,
//                                 categoryName: item["name"]!,
//                                 categoryImageUrl: item["image"]!,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       const SizedBox(height: 24),
//                       buildSection(
//                         title: "New releases",
//                         items: homeState.albums
//                             .map((e) => {
//                                   "id": e.id ?? "",
//                                   "name": e.name ?? "",
//                                   "image": e.imageUrl ?? "",
//                                 })
//                             .take(9)
//                             .toList(),
//                         onTap: (item) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (_) => AlbumDetailScreen(
//                                 albumId: item["id"]!,
//                                 albumName: item["name"]!,
//                                 albumImageUrl: item["image"]!,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//           bottomNavigationBar: const MiniPlayer(),
//         ),

//         // SIDEBAR
//         if (showMenu) ...[
//           GestureDetector(
//             onTap: () => setState(() => showMenu = false),
//             child: Container(color: Colors.black.withOpacity(0.55)),
//           ),
//           AnimatedPositioned(
//             duration: const Duration(milliseconds: 260),
//             left: showMenu ? 0 : -240,
//             top: 0,
//             bottom: 0,
//             child: Container(
//               width: 240,
//               padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 18),
//               decoration: const BoxDecoration(color: Color(0xFF1B1B1B)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       setState(() => showMenu = false);
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const ProfileScreen(),
//                         ),
//                       );
//                     },
//                     child: const Text(
//                       "Profile",
//                       style: TextStyle(
//                           color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   const SizedBox(height: 28),
//                   GestureDetector(
//                     onTap: logout,
//                     child: const Text(
//                       "Logout",
//                       style: TextStyle(
//                           color: Colors.red, fontSize: 18, fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   const Spacer(),
//                   GestureDetector(
//                     onTap: () => setState(() => showMenu = false),
//                     child: const Text("Close",
//                         style: TextStyle(color: Colors.white70, fontSize: 16)),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ]
//       ],
//     );
//   }

//   Widget buildSection({
//     required String title,
//     required List<Map<String, String>> items,
//     required Function(Map<String, String>) onTap,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//               color: Colors.white, fontSize: 21, fontWeight: FontWeight.w600),
//         ),
//         const SizedBox(height: 14),
//         GridView.builder(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemCount: items.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//             crossAxisSpacing: 14,
//             mainAxisSpacing: 18,
//             childAspectRatio: 0.78,
//           ),
//           itemBuilder: (_, index) {
//             final item = items[index];
//             return GestureDetector(
//               onTap: () => onTap(item),
//               child: Column(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.network(
//                       item["image"]!,
//                       height: 110,
//                       width: 110,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     item["name"]!,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(color: Colors.white, fontSize: 12),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/home_provider.dart';
import '../screens/loading_screen.dart';
import '../screens/playlist_detail_screen.dart';
import '../screens/category_playlists_screen.dart';
import '../screens/album_detail_screen.dart';
import '../screens/profile_screen.dart';
import '../auth/login_screen.dart';
import '../widgets/mini_player.dart';
import '../widgets/music_image.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(homeProvider.notifier).fetchHomeData();
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  void _openProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ProfileScreen(
          username: "Rahul",      // TEMP — static dummy values
          email: "rahul@example.com",
        ),
      ),
    );
  }

  void _openMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title: const Text("Profile",
                    style: TextStyle(color: Colors.white, fontSize: 17)),
                onTap: () {
                  Navigator.pop(context);
                  _openProfile();
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: const Text("Logout",
                    style: TextStyle(color: Colors.redAccent, fontSize: 17)),
                onTap: () {
                  Navigator.pop(context);
                  _logout();
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeProvider);

    if (homeState.isLoading) return const LoadingScreen();

    if (homeState.errorMessage != null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(homeState.errorMessage!,
                  style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => ref.read(homeProvider.notifier).fetchHomeData(),
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: MusicImage(
          imageUrl: "https://cdn-icons-png.flaticon.com/512/727/727240.png",
          width: 26,
          height: 26,
          fit: BoxFit.contain,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: _openMenu,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ============= EDITOR'S PICKS =============
            buildSection(
              title: "Editor's picks",
              items: homeState.playlists
                  .map((e) => {
                        "id": e.id ?? "",
                        "name": e.name ?? "",
                        "image": e.imageUrl ?? "",
                      })
                  .take(9)
                  .toList(),
              onTap: (item) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlaylistDetailScreen(
                      playlistId: item["id"]!,
                      playlistName: item["name"]!,
                      playlistImageUrl: item["image"]!,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // ============= GENRES & MOODS =============
            buildSection(
              title: "Genres & Moods",
              items: homeState.categories
                  .map((e) => {
                        "id": e.id ?? "",
                        "name": e.name ?? "",
                        "image": e.imageUrl ?? "",
                      })
                  .take(9)
                  .toList(),
              onTap: (item) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryPlaylistsScreen(
                      categoryId: item["id"]!,
                      categoryName: item["name"]!,
                      categoryImageUrl: item["image"]!,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // ============= NEW RELEASES =============
            buildSection(
              title: "New releases",
              items: homeState.albums
                  .map((e) => {
                        "id": e.id ?? "",
                        "name": e.name ?? "",
                        "image": e.imageUrl ?? "",
                      })
                  .take(9)
                  .toList(),
              onTap: (item) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AlbumDetailScreen(
                      albumId: item["id"]!,
                      albumName: item["name"]!,
                      albumImageUrl: item["image"]!,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MiniPlayer(),
    );
  }

  Widget buildSection({
    required String title,
    required List<Map<String, String>> items,
    required Function(Map<String, String>) onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.white, fontSize: 21, fontWeight: FontWeight.w600)),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 14,
            mainAxisSpacing: 18,
            childAspectRatio: 0.78,
          ),
          itemBuilder: (_, index) {
            final item = items[index];
            return GestureDetector(
              onTap: () => onTap(item),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: MusicImage(
                      imageUrl: item["image"]!,
                      height: 110,
                      width: 110,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item["name"]!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
