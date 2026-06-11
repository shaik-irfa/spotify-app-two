// // import 'package:audioplayers/audioplayers.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // class AudioState {
// //   final bool isPlaying;
// //   final String? title;
// //   final String? artist;
// //   final String? imageUrl;
// //   final String? previewUrl;

// //   const AudioState({
// //     this.isPlaying = false,
// //     this.title,
// //     this.artist,
// //     this.imageUrl,
// //     this.previewUrl,
// //   });

// //   AudioState copyWith({
// //     bool? isPlaying,
// //     String? title,
// //     String? artist,
// //     String? imageUrl,
// //     String? previewUrl,
// //   }) {
// //     return AudioState(
// //       isPlaying: isPlaying ?? this.isPlaying,
// //       title: title ?? this.title,
// //       artist: artist ?? this.artist,
// //       imageUrl: imageUrl ?? this.imageUrl,
// //       previewUrl: previewUrl ?? this.previewUrl,
// //     );
// //   }

// //   bool get hasSong => previewUrl != null && previewUrl!.isNotEmpty;
// // }

// // class AudioNotifier extends StateNotifier<AudioState> {
// //   final AudioPlayer _player = AudioPlayer();

// //   AudioNotifier() : super(const AudioState()) {
// //     _player.onPlayerComplete.listen((event) {
// //       state = state.copyWith(isPlaying: false);
// //     });
// //   }

// //   Future<void> playSong({
// //     required String url,
// //     required String title,
// //     required String artist,
// //     required String imageUrl,
// //   }) async {
// //     await _player.stop();
// //     await _player.play(UrlSource(url));
// //     state = state.copyWith(
// //       previewUrl: url,
// //       title: title,
// //       artist: artist,
// //       imageUrl: imageUrl,
// //       isPlaying: true,
// //     );
// //   }

// //   Future<void> pause() async {
// //     await _player.pause();
// //     state = state.copyWith(isPlaying: false);
// //   }

// //   Future<void> resume() async {
// //     await _player.resume();
// //     state = state.copyWith(isPlaying: true);
// //   }
// // }

// // final audioProvider =
// //     StateNotifierProvider<AudioNotifier, AudioState>((ref) {
// //   return AudioNotifier();
// // });

// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class AudioState {
//   final bool isPlaying;
//   final String? title;
//   final String? artist;
//   final String? imageUrl;
//   final String? previewUrl;

//   const AudioState({
//     this.isPlaying = false,
//     this.title,
//     this.artist,
//     this.imageUrl,
//     this.previewUrl,
//   });

//   AudioState copyWith({
//     bool? isPlaying,
//     String? title,
//     String? artist,
//     String? imageUrl,
//     String? previewUrl,
//   }) {
//     return AudioState(
//       isPlaying: isPlaying ?? this.isPlaying,
//       title: title ?? this.title,
//       artist: artist ?? this.artist,
//       imageUrl: imageUrl ?? this.imageUrl,
//       previewUrl: previewUrl ?? this.previewUrl,
//     );
//   }

//   bool get hasSong => previewUrl != null && previewUrl!.isNotEmpty;
// }

// class AudioNotifier extends StateNotifier<AudioState> {
//   final AudioPlayer _player = AudioPlayer();

//   AudioNotifier() : super(const AudioState()) {
//     _player.onPlayerComplete.listen((_) {
//       state = state.copyWith(isPlaying: false);
//     });
//   }

//   Future<void> playSong({
//     required String url,
//     required String title,
//     required String artist,
//     required String imageUrl,
//   }) async {
//     if (state.previewUrl == url) {
//       // Resume if same song tapped again
//       resume();
//       return;
//     }

//     await _player.stop();
//     await _player.play(UrlSource(url));

//     state = state.copyWith(
//       previewUrl: url,
//       title: title,
//       artist: artist,
//       imageUrl: imageUrl,
//       isPlaying: true,
//     );
//   }

//   Future<void> pause() async {
//     await _player.pause();
//     state = state.copyWith(isPlaying: false);
//   }

//   Future<void> resume() async {
//     await _player.resume();
//     state = state.copyWith(isPlaying: true);
//   }
// }

// final audioProvider = StateNotifierProvider<AudioNotifier, AudioState>((ref) {
//   return AudioNotifier();
// });

import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/song_model.dart';

class AudioState {
  final bool isPlaying;
  final bool isLoading;
  final String? errorMessage;
  final String? title;
  final String? artist;
  final String? imageUrl;
  final String? previewUrl;
  final List<SongModel> queue;
  final int currentIndex;

  const AudioState({
    this.isPlaying = false,
    this.isLoading = false,
    this.errorMessage,
    this.title,
    this.artist,
    this.imageUrl,
    this.previewUrl,
    this.queue = const [],
    this.currentIndex = -1,
  });

  AudioState copyWith({
    bool? isPlaying,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    String? title,
    String? artist,
    String? imageUrl,
    String? previewUrl,
    List<SongModel>? queue,
    int? currentIndex,
  }) {
    return AudioState(
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      title: title ?? this.title,
      artist: artist ?? this.artist,
      imageUrl: imageUrl ?? this.imageUrl,
      previewUrl: previewUrl ?? this.previewUrl,
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  bool get hasSong => previewUrl != null && previewUrl!.isNotEmpty;
}

class AudioNotifier extends StateNotifier<AudioState> {
  final AudioPlayer _player = AudioPlayer();
  Duration _totalDuration = Duration.zero;

  AudioNotifier() : super(const AudioState()) {
    _player.onDurationChanged.listen((d) {
      _totalDuration = d;
    });

    _player.onPlayerComplete.listen((_) {
      playNext();
    });
  }

  // ===== Progress bar helpers =====
  Stream<Duration> get positionStream => _player.onPositionChanged;
  Duration get totalDuration => _totalDuration;

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }

  // ===== Play with queue =====
  Future<void> playWithQueue({
    required List<SongModel> songs,
    required int index,
    required String imageUrl,
  }) async {
    final song = songs[index];
    
    // Reset status and set loading state first
    state = state.copyWith(
      queue: songs,
      currentIndex: index,
      previewUrl: song.previewUrl,
      title: song.name,
      artist: song.artistName,
      imageUrl: imageUrl,
      isLoading: true,
      isPlaying: false,
      clearError: true,
    );
    
    _totalDuration = Duration.zero;

    if ((song.previewUrl ?? "").isEmpty) {
      state = state.copyWith(
        isLoading: false,
        isPlaying: false,
        errorMessage: "Preview unavailable",
      );
      return;
    }

    try {
      // Reset/stop the player before loading a new track
      await _player.stop();
      
      // Load and start playing
      await _player.play(UrlSource(song.previewUrl!));
      
      // Ensure playback always starts from 0:00
      await _player.seek(Duration.zero);

      state = state.copyWith(
        isLoading: false,
        isPlaying: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isPlaying: false,
        errorMessage: "Preview unavailable",
      );
    }
  }

  Future<void> playNext() async {
    if (state.queue.isEmpty) return;
    final nextIndex = state.currentIndex + 1;
    if (nextIndex >= state.queue.length) return;

    await playWithQueue(
      songs: state.queue,
      index: nextIndex,
      imageUrl: state.imageUrl ?? "",
    );
  }

  Future<void> playPrevious() async {
    if (state.queue.isEmpty) return;
    final prevIndex = state.currentIndex - 1;
    if (prevIndex < 0) return;

    await playWithQueue(
      songs: state.queue,
      index: prevIndex,
      imageUrl: state.imageUrl ?? "",
    );
  }

  Future<void> pause() async {
    await _player.pause();
    state = state.copyWith(isPlaying: false);
  }

  Future<void> resume() async {
    try {
      await _player.resume();
      state = state.copyWith(isPlaying: true);
    } catch (e) {
      state = state.copyWith(
        isPlaying: false,
        errorMessage: "Preview unavailable",
      );
    }
  }
}

final audioProvider =
    StateNotifierProvider<AudioNotifier, AudioState>((ref) {
  return AudioNotifier();
});
