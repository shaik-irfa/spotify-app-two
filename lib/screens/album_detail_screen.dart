// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../provider/album_provider.dart';
// import '../provider/audio_provider.dart';
// import '../widgets/mini_player.dart';

// class AlbumDetailScreen extends ConsumerStatefulWidget {
//   final String albumId;
//   final String albumName;
//   final String albumImageUrl;

//   const AlbumDetailScreen({
//     super.key,
//     required this.albumId,
//     required this.albumName,
//     required this.albumImageUrl,
//   });

//   @override
//   ConsumerState<AlbumDetailScreen> createState() => _AlbumDetailScreenState();
// }

// class _AlbumDetailScreenState extends ConsumerState<AlbumDetailScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       ref.read(albumProvider.notifier).loadAlbum(widget.albumId);
//     });
//   }

//   void playSong(String url, String name, String artist) {
//     final audioNotifier = ref.read(audioProvider.notifier);
//     final audioState = ref.read(audioProvider);

//     // If same song tapped again → toggle pause/play
//     if (audioState.previewUrl == url) {
//       audioState.isPlaying ? audioNotifier.pause() : audioNotifier.resume();
//       return;
//     }

//     // New song
//     audioNotifier.playSong(
//       url: url,
//       title: name,
//       artist: artist,
//       imageUrl: widget.albumImageUrl,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final albumState = ref.watch(albumProvider);
//     final audioState = ref.watch(audioProvider);

//     return Scaffold(
//       backgroundColor: const Color(0xFF111111),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF111111),
//         elevation: 0,
//         leading: const BackButton(color: Colors.white),
//         title: const Text("Back", style: TextStyle(color: Colors.white)),
//       ),
//       body: albumState.isLoading
//           ? const Center(child: CircularProgressIndicator(color: Colors.green))
//           : ListView(
//               padding: const EdgeInsets.symmetric(horizontal: 22),
//               children: [
//                 const SizedBox(height: 15),
//                 Center(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(16),
//                     child: Image.network(
//                       widget.albumImageUrl,
//                       height: 230,
//                       width: 230,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   widget.albumName,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   "Album",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.7),
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 25),

//                 // SONG LIST
//                 ...albumState.songs.map((song) {
//                   final duration = song.durationMs ?? 0;
//                   final mins = duration ~/ 60000;
//                   final secs =
//                       ((duration % 60000) ~/ 1000).toString().padLeft(2, '0');

//                   final isPlaying = audioState.previewUrl == song.previewUrl;

//                   return InkWell(
//                     onTap: () {
//                       if ((song.previewUrl ?? "").isNotEmpty) {
//                         playSong(
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


// latest oneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../provider/album_provider.dart';
// import '../provider/audio_provider.dart';
// import '../widgets/mini_player.dart';

// class AlbumDetailScreen extends ConsumerStatefulWidget {
//   final String albumId;
//   final String albumName;
//   final String albumImageUrl;

//   const AlbumDetailScreen({
//     super.key,
//     required this.albumId,
//     required this.albumName,
//     required this.albumImageUrl,
//   });

//   @override
//   ConsumerState<AlbumDetailScreen> createState() => _AlbumDetailScreenState();
// }

// class _AlbumDetailScreenState extends ConsumerState<AlbumDetailScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       ref.read(albumProvider.notifier).loadAlbum(widget.albumId);
//     });
//   }

//   void toggleSongPlay(String url, String title, String artist) {
//     final audioNotifier = ref.read(audioProvider.notifier);
//     final audioState = ref.read(audioProvider);

//     if (audioState.previewUrl == url) {
//       audioState.isPlaying ? audioNotifier.pause() : audioNotifier.resume();
//       return;
//     }

//     audioNotifier.playSong(
//       url: url,
//       title: title,
//       artist: artist,
//       imageUrl: widget.albumImageUrl,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final albumState = ref.watch(albumProvider);
//     final audioState = ref.watch(audioProvider);

//     return Scaffold(
//       backgroundColor: const Color(0xFF111111),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF111111),
//         elevation: 0,
//         leading: const BackButton(color: Colors.white),
//         title: const Text("Back", style: TextStyle(color: Colors.white)),
//       ),
//       body: albumState.isLoading
//           ? const Center(child: CircularProgressIndicator(color: Colors.green))
//           : ListView(
//               padding: const EdgeInsets.symmetric(horizontal: 22),
//               children: [
//                 const SizedBox(height: 15),
//                 Center(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(16),
//                     child: Image.network(
//                       widget.albumImageUrl,
//                       height: 230,
//                       width: 230,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Text(
//                   widget.albumName,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 28),

//                 ...albumState.songs.map((song) {
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
//                             isPlaying
//                                 ? Icons.pause_circle
//                                 : Icons.play_circle_fill,
//                             color: isPlaying ? Colors.green : Colors.white,
//                             size: 35,
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
import '../provider/album_provider.dart';
import '../provider/audio_provider.dart';
import '../widgets/mini_player.dart';

class AlbumDetailScreen extends ConsumerStatefulWidget {
  final String albumId;
  final String albumName;
  final String albumImageUrl;

  const AlbumDetailScreen({
    super.key,
    required this.albumId,
    required this.albumName,
    required this.albumImageUrl,
  });

  @override
  ConsumerState<AlbumDetailScreen> createState() =>
      _AlbumDetailScreenState();
}

class _AlbumDetailScreenState
    extends ConsumerState<AlbumDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(albumProvider.notifier).loadAlbum(widget.albumId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final albumState = ref.watch(albumProvider);
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
      body: albumState.isLoading
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
                    child: Image.network(
                      widget.albumImageUrl,
                      height: 230,
                      width: 230,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.albumName,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 28),

                // SONG LIST
                ...List.generate(albumState.songs.length, (index) {
                  final song = albumState.songs[index];
                  final isCurrent = audioState.previewUrl == song.previewUrl;
                  final isPlaying = isCurrent && audioState.isPlaying;
                  final isLoading = isCurrent && audioState.isLoading;

                  final duration = song.durationMs ?? 0;
                  final mins = duration ~/ 60000;
                  final secs =
                      ((duration % 60000) ~/ 1000).toString().padLeft(2, '0');

                  return InkWell(
                    onTap: () {
                      if ((song.previewUrl ?? "").isEmpty) return;

                      // Same song → pause / resume
                      if (audioState.previewUrl == song.previewUrl) {
                        audioState.isPlaying
                            ? audioController.pause()
                            : audioController.resume();
                        return;
                      }

                      // New song → play with album queue
                      audioController.playWithQueue(
                        songs: albumState.songs,
                        index: index,
                        imageUrl: widget.albumImageUrl,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          if (isLoading)
                            const SizedBox(
                              width: 35,
                              height: 35,
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
                              size: 35,
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
