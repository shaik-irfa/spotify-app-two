// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../provider/playlist_provider.dart';
// import '../provider/audio_provider.dart';
// import '../widgets/mini_player.dart';

// class PlaylistDetailScreen extends ConsumerStatefulWidget {
//   final String playlistId;
//   final String playlistName;
//   final String playlistImageUrl;

//   const PlaylistDetailScreen({
//     super.key,
//     required this.playlistId,
//     required this.playlistName,
//     required this.playlistImageUrl,
//   });

//   @override
//   ConsumerState<PlaylistDetailScreen> createState() =>
//       _PlaylistDetailScreenState();
// }

// class _PlaylistDetailScreenState
//     extends ConsumerState<PlaylistDetailScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       ref.read(playlistProvider.notifier).loadPlaylist(widget.playlistId);
//     });
//   }

//   void toggleSongPlay(String url, String name, String artist) {
//     final audioNotifier = ref.read(audioProvider.notifier);
//     final audioState = ref.read(audioProvider);

//     // Same song tapped → pause / resume
//     if (audioState.previewUrl == url) {
//       audioState.isPlaying ? audioNotifier.pause() : audioNotifier.resume();
//       return;
//     }

//     // New song
//     audioNotifier.playSong(
//       url: url,
//       title: name,
//       artist: artist,
//       imageUrl: widget.playlistImageUrl,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final playlistState = ref.watch(playlistProvider);
//     final audioState = ref.watch(audioProvider);

//     return Scaffold(
//       backgroundColor: const Color(0xFF111111),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF111111),
//         elevation: 0,
//         leading: const BackButton(color: Colors.white),
//         title: const Text("Back", style: TextStyle(color: Colors.white)),
//       ),
//       body: playlistState.isLoading
//           ? const Center(child: CircularProgressIndicator(color: Colors.green))
//           : ListView(
//               physics: const BouncingScrollPhysics(),
//               padding: const EdgeInsets.symmetric(horizontal: 22),
//               children: [
//                 const SizedBox(height: 15),
//                 Center(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(16),
//                     child: Image.network(
//                       widget.playlistImageUrl,
//                       height: 230,
//                       width: 230,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   widget.playlistName,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   "Playlist",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.7),
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 25),

//                 ...playlistState.songs.map((song) {
//                   final duration = song.durationMs ?? 0;
//                   final mins = duration ~/ 60000;
//                   final secs =
//                       ((duration % 60000) ~/ 1000).toString().padLeft(2, '0');

//                   final isPlaying = audioState.previewUrl == song.previewUrl;

//                   return InkWell(
//                     onTap: () {
//                       if ((song.previewUrl ?? "").isNotEmpty) {
//                         toggleSongPlay(
//                           song.previewUrl!,
//                           song.name ?? "",
//                           song.artistName ?? "",
//                         );
//                       }
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       child: Row(
//                         children: [
//                           Icon(
//                             isPlaying ? Icons.pause_circle :
//                                         Icons.play_circle_fill,
//                             color: isPlaying ? Colors.green : Colors.white,
//                             size: 34,
//                           ),
//                           const SizedBox(width: 14),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   song.name ?? "",
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 3),
//                                 Text(
//                                   song.artistName ?? "",
//                                   style: TextStyle(
//                                     color: Colors.white.withOpacity(0.7),
//                                     fontSize: 13,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Text(
//                             "$mins:$secs",
//                             style: TextStyle(
//                               color: Colors.white.withOpacity(0.7),
//                               fontSize: 13,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),

//                 const SizedBox(height: 70),
//               ],
//             ),
//       bottomNavigationBar: const MiniPlayer(),
//     );
//   }
// }

// latest oneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../provider/playlist_provider.dart';
// import '../provider/audio_provider.dart';
// import '../widgets/mini_player.dart';

// class PlaylistDetailScreen extends ConsumerStatefulWidget {
//   final String playlistId;
//   final String playlistName;
//   final String playlistImageUrl;

//   const PlaylistDetailScreen({
//     super.key,
//     required this.playlistId,
//     required this.playlistName,
//     required this.playlistImageUrl,
//   });

//   @override
//   ConsumerState<PlaylistDetailScreen> createState() =>
//       _PlaylistDetailScreenState();
// }

// class _PlaylistDetailScreenState
//     extends ConsumerState<PlaylistDetailScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       ref.read(playlistProvider.notifier).loadPlaylist(widget.playlistId);
//     });
//   }

//   void toggleSong(String url, String name, String artist) {
//     final audio = ref.read(audioProvider);
//     final controller = ref.read(audioProvider.notifier);

//     if (audio.previewUrl == url) {
//       audio.isPlaying ? controller.pause() : controller.resume();
//     } else {
//       controller.playSong(
//         url: url,
//         title: name,
//         artist: artist,
//         imageUrl: widget.playlistImageUrl,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final playlistState = ref.watch(playlistProvider);
//     final audioState = ref.watch(audioProvider);

//     return Scaffold(
//       backgroundColor: const Color(0xFF111111),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF111111),
//         elevation: 0,
//         leading: const BackButton(color: Colors.white),
//         title: const Text("Back", style: TextStyle(color: Colors.white)),
//       ),
//       body: playlistState.isLoading
//           ? const Center(child: CircularProgressIndicator(color: Colors.green))
//           : ListView(
//               padding: const EdgeInsets.symmetric(horizontal: 22),
//               children: [
//                 const SizedBox(height: 15),
//                 Center(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(16),
//                     child: Image.network(
//                       widget.playlistImageUrl,
//                       height: 230,
//                       width: 230,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   widget.playlistName,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   "Playlist",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.7),
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 25),

//                 ...playlistState.songs.map((song) {
//                   final isPlaying = audioState.previewUrl == song.previewUrl;

//                   final dur = song.durationMs ?? 0;
//                   final mins = dur ~/ 60000;
//                   final secs =
//                       ((dur % 60000) ~/ 1000).toString().padLeft(2, '0');

//                   return InkWell(
//                     onTap: () {
//                       if ((song.previewUrl ?? "").isNotEmpty) {
//                         toggleSong(
//                           song.previewUrl!,
//                           song.name ?? "",
//                           song.artistName ?? "",
//                         );
//                       }
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 9),
//                       child: Row(
//                         children: [
//                           Icon(
//                             isPlaying
//                                 ? Icons.pause_circle
//                                 : Icons.play_circle_fill,
//                             color: isPlaying ? Colors.green : Colors.white,
//                             size: 34,
//                           ),
//                           const SizedBox(width: 14),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   song.name ?? "",
//                                   style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 const SizedBox(height: 3),
//                                 Text(
//                                   song.artistName ?? "",
//                                   style: TextStyle(
//                                     color: Colors.white.withOpacity(0.7),
//                                     fontSize: 13,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Text(
//                             "$mins:$secs",
//                             style: TextStyle(
//                               color: Colors.white.withOpacity(0.7),
//                               fontSize: 13,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 }).toList(),

//                 const SizedBox(height: 70),
//               ],
//             ),
//       bottomNavigationBar: const MiniPlayer(),
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/playlist_provider.dart';
import '../provider/audio_provider.dart';
import '../widgets/mini_player.dart';
import '../widgets/music_image.dart';

class PlaylistDetailScreen extends ConsumerStatefulWidget {
  final String playlistId;
  final String playlistName;
  final String playlistImageUrl;

  const PlaylistDetailScreen({
    super.key,
    required this.playlistId,
    required this.playlistName,
    required this.playlistImageUrl,
  });

  @override
  ConsumerState<PlaylistDetailScreen> createState() =>
      _PlaylistDetailScreenState();
}

class _PlaylistDetailScreenState
    extends ConsumerState<PlaylistDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(playlistProvider.notifier).loadPlaylist(widget.playlistId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final playlistState = ref.watch(playlistProvider);
    final audioState = ref.watch(audioProvider);
    final audioController = ref.read(audioProvider.notifier);

    ref.listen(audioProvider, (previous, next) {
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
        ref.read(audioProvider.notifier).clearError();
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111111),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text("Back", style: TextStyle(color: Colors.white)),
      ),
      body: playlistState.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.green),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              children: [
                const SizedBox(height: 15),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: MusicImage(
                      imageUrl: widget.playlistImageUrl,
                      height: 230,
                      width: 230,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.playlistName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Playlist",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 25),

                // SONG LIST
                ...List.generate(playlistState.songs.length, (index) {
                  final song = playlistState.songs[index];
                  final isCurrent = audioState.previewUrl == song.previewUrl;
                  final isPlaying = isCurrent && audioState.isPlaying;
                  final isLoading = isCurrent && audioState.isLoading;

                  final dur = song.durationMs ?? 0;
                  final mins = dur ~/ 60000;
                  final secs =
                      ((dur % 60000) ~/ 1000).toString().padLeft(2, '0');

                  return InkWell(
                    onTap: () {
                      if ((song.previewUrl ?? "").isEmpty) return;

                      // SAME SONG → pause / resume
                      if (audioState.previewUrl == song.previewUrl) {
                        audioState.isPlaying
                            ? audioController.pause()
                            : audioController.resume();
                        return;
                      }

                      // NEW SONG → play with queue
                      audioController.playWithQueue(
                        songs: playlistState.songs,
                        index: index,
                        imageUrl: widget.playlistImageUrl,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      child: Row(
                        children: [
                          if (isLoading)
                            const SizedBox(
                              width: 34,
                              height: 34,
                              child: Padding(
                                padding: EdgeInsets.all(5.0),
                                child: CircularProgressIndicator(
                                  color: Colors.green,
                                  strokeWidth: 2.5,
                                ),
                              ),
                            )
                          else
                            Icon(
                              isPlaying
                                  ? Icons.pause_circle
                                  : Icons.play_circle_fill,
                              color:
                                  isPlaying ? Colors.green : Colors.white,
                              size: 34,
                            ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  song.name ?? "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  song.artistName ?? "",
                                  style: TextStyle(
                                    color:
                                        Colors.white.withValues(alpha: 0.7),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "$mins:$secs",
                            style: TextStyle(
                              color:
                                  Colors.white.withValues(alpha: 0.7),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 70),
              ],
            ),
      bottomNavigationBar: const MiniPlayer(),
    );
  }
}
