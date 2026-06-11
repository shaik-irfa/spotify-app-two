// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import '../provider/audio_provider.dart';

// // class MiniPlayer extends ConsumerWidget {
// //   const MiniPlayer({super.key});

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final audioState = ref.watch(audioProvider);
// //     final controller = ref.read(audioProvider.notifier);

// //     // If no song played yet, hide
// //     if (!audioState.hasSong) return const SizedBox.shrink();

// //     return Container(
// //       height: 62,
// //       padding: const EdgeInsets.symmetric(horizontal: 12),
// //       decoration: const BoxDecoration(
// //         color: Color(0xFF0F0F0F),
// //         border: Border(
// //           top: BorderSide(color: Colors.black, width: 0.35),
// //         ),
// //       ),
// //       child: Row(
// //         children: [
// //           // Thumbnail
// //           ClipRRect(
// //             borderRadius: BorderRadius.circular(5),
// //             child: Image.network(
// //               audioState.imageUrl ?? "",
// //               width: 45,
// //               height: 45,
// //               fit: BoxFit.cover,
// //             ),
// //           ),
// //           const SizedBox(width: 10),

// //           // Song Title + Artist
// //           Expanded(
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   audioState.title ?? "",
// //                   overflow: TextOverflow.ellipsis,
// //                   style: const TextStyle(
// //                     color: Colors.white,
// //                     fontWeight: FontWeight.w600,
// //                     fontSize: 14,
// //                   ),
// //                 ),
// //                 Text(
// //                   audioState.artist ?? "",
// //                   overflow: TextOverflow.ellipsis,
// //                   style: TextStyle(
// //                     color: Colors.white.withOpacity(0.75),
// //                     fontSize: 12,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),

// //           // Pause/Resume button
// //           GestureDetector(
// //             onTap: () {
// //               if (audioState.isPlaying) {
// //                 controller.pause();
// //               } else {
// //                 controller.resume();
// //               }
// //             },
// //             child: Icon(
// //               audioState.isPlaying ? Icons.pause : Icons.play_arrow,
// //               size: 30,
// //               color: Colors.white,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// // latest oneeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import '../provider/audio_provider.dart';

// // class MiniPlayer extends ConsumerWidget {
// //   const MiniPlayer({super.key});

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     final audioState = ref.watch(audioProvider);
// //     final controller = ref.read(audioProvider.notifier);

// //     if (!audioState.hasSong) return const SizedBox.shrink();

// //     return Container(
// //       height: 62,
// //       padding: const EdgeInsets.symmetric(horizontal: 12),
// //       decoration: const BoxDecoration(
// //         color: Color(0xFF0F0F0F),
// //       ),
// //       child: Row(
// //         children: [
// //           ClipRRect(
// //             borderRadius: BorderRadius.circular(5),
// //             child: Image.network(
// //               audioState.imageUrl ?? "",
// //               width: 45,
// //               height: 45,
// //               fit: BoxFit.cover,
// //             ),
// //           ),
// //           const SizedBox(width: 10),

// //           Expanded(
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   audioState.title ?? "",
// //                   overflow: TextOverflow.ellipsis,
// //                   style: const TextStyle(
// //                     color: Colors.white,
// //                     fontWeight: FontWeight.w600,
// //                     fontSize: 14,
// //                   ),
// //                 ),
// //                 Text(
// //                   audioState.artist ?? "",
// //                   overflow: TextOverflow.ellipsis,
// //                   style: TextStyle(
// //                     color: Colors.white.withOpacity(0.75),
// //                     fontSize: 12,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),

// //           GestureDetector(
// //             onTap: () {
// //               audioState.isPlaying ? controller.pause() : controller.resume();
// //             },
// //             child: Icon(
// //               audioState.isPlaying ? Icons.pause : Icons.play_arrow,
// //               size: 30,
// //               color: Colors.white,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }







// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../provider/audio_provider.dart';

// class MiniPlayer extends ConsumerWidget {
//   const MiniPlayer({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final audioState = ref.watch(audioProvider);
//     final controller = ref.read(audioProvider.notifier);

//     if (!audioState.hasSong) return const SizedBox.shrink();

//     return Container(
//       height: 62,
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       decoration: const BoxDecoration(
//         color: Color(0xFF0F0F0F),
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(5),
//             child: Image.network(
//               audioState.imageUrl ?? "",
//               width: 45,
//               height: 45,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(width: 10),

//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   audioState.title ?? "",
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14,
//                   ),
//                 ),
//                 Text(
//                   audioState.artist ?? "",
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.75),
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           GestureDetector(
//             onTap: () {
//               audioState.isPlaying ? controller.pause() : controller.resume();
//             },
//             child: Icon(
//               audioState.isPlaying ? Icons.pause : Icons.play_arrow,
//               size: 30,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/audio_provider.dart';
import '../screens/now_playing_screen.dart';
import 'music_image.dart';

class MiniPlayer extends ConsumerWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(audioProvider);
    final controller = ref.read(audioProvider.notifier);

    // Hide mini player if no song is selected
    if (!audioState.hasSong) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const NowPlayingScreen(),
          ),
        );
      },
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: const BoxDecoration(
          color: Color(0xFF0F0F0F),
          border: Border(
            top: BorderSide(color: Colors.black, width: 0.4),
          ),
        ),
        child: Row(
          children: [
            // ===== Album / Playlist Image =====
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: MusicImage(
                imageUrl: audioState.imageUrl ?? "",
                width: 46,
                height: 46,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),

            // ===== Song Info =====
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    audioState.title ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    audioState.artist ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // ===== Previous =====
            IconButton(
              onPressed: controller.playPrevious,
              icon: const Icon(
                Icons.skip_previous,
                color: Colors.white,
                size: 28,
              ),
            ),

            // ===== Play / Pause / Loading =====
            if (audioState.isLoading)
              const SizedBox(
                width: 48,
                height: 48,
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: CircularProgressIndicator(
                    color: Colors.green,
                    strokeWidth: 2.5,
                  ),
                ),
              )
            else
              IconButton(
                onPressed: () {
                  audioState.isPlaying
                      ? controller.pause()
                      : controller.resume();
                },
                icon: Icon(
                  audioState.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Colors.white,
                  size: 30,
                ),
              ),

            // ===== Next =====
            IconButton(
              onPressed: controller.playNext,
              icon: const Icon(
                Icons.skip_next,
                color: Colors.white,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
