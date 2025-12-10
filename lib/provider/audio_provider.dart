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
//     _player.onPlayerComplete.listen((event) {
//       state = state.copyWith(isPlaying: false);
//     });
//   }

//   Future<void> playSong({
//     required String url,
//     required String title,
//     required String artist,
//     required String imageUrl,
//   }) async {
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

// final audioProvider =
//     StateNotifierProvider<AudioNotifier, AudioState>((ref) {
//   return AudioNotifier();
// });

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioState {
  final bool isPlaying;
  final String? title;
  final String? artist;
  final String? imageUrl;
  final String? previewUrl;

  const AudioState({
    this.isPlaying = false,
    this.title,
    this.artist,
    this.imageUrl,
    this.previewUrl,
  });

  AudioState copyWith({
    bool? isPlaying,
    String? title,
    String? artist,
    String? imageUrl,
    String? previewUrl,
  }) {
    return AudioState(
      isPlaying: isPlaying ?? this.isPlaying,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      imageUrl: imageUrl ?? this.imageUrl,
      previewUrl: previewUrl ?? this.previewUrl,
    );
  }

  bool get hasSong => previewUrl != null && previewUrl!.isNotEmpty;
}

class AudioNotifier extends StateNotifier<AudioState> {
  final AudioPlayer _player = AudioPlayer();

  AudioNotifier() : super(const AudioState()) {
    _player.onPlayerComplete.listen((_) {
      state = state.copyWith(isPlaying: false);
    });
  }

  Future<void> playSong({
    required String url,
    required String title,
    required String artist,
    required String imageUrl,
  }) async {
    if (state.previewUrl == url) {
      // Resume if same song tapped again
      resume();
      return;
    }

    await _player.stop();
    await _player.play(UrlSource(url));

    state = state.copyWith(
      previewUrl: url,
      title: title,
      artist: artist,
      imageUrl: imageUrl,
      isPlaying: true,
    );
  }

  Future<void> pause() async {
    await _player.pause();
    state = state.copyWith(isPlaying: false);
  }

  Future<void> resume() async {
    await _player.resume();
    state = state.copyWith(isPlaying: true);
  }
}

final audioProvider = StateNotifierProvider<AudioNotifier, AudioState>((ref) {
  return AudioNotifier();
});
