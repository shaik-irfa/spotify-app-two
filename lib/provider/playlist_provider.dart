import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/playlist_service.dart';
import '../models/song_model.dart';

class PlaylistState {
  final bool isLoading;
  final String? errorMessage;
  final String playlistName;
  final String playlistImageUrl;
  final List<SongModel> songs;

  const PlaylistState({
    this.isLoading = false,
    this.errorMessage,
    this.playlistName = "",
    this.playlistImageUrl = "",
    this.songs = const [],
  });

  PlaylistState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? playlistName,
    String? playlistImageUrl,
    List<SongModel>? songs,
  }) {
    return PlaylistState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      playlistName: playlistName ?? this.playlistName,
      playlistImageUrl: playlistImageUrl ?? this.playlistImageUrl,
      songs: songs ?? this.songs,
    );
  }
}

class PlaylistNotifier extends StateNotifier<PlaylistState> {
  PlaylistNotifier() : super(const PlaylistState());

  final PlaylistService _service = PlaylistService();

  Future<void> loadPlaylist(String playlistId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _service.getPlaylistDetails(playlistId);

    if (result == null) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Failed to load playlist",
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        playlistName: result["playlistName"],
        playlistImageUrl: result["playlistImageUrl"],
        songs: result["songs"],
      );
    }
  }
}

final playlistProvider =
    StateNotifierProvider<PlaylistNotifier, PlaylistState>(
  (ref) => PlaylistNotifier(),
);
  