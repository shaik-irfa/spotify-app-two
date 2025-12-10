import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/song_model.dart';
import '../services/album_service.dart';

class AlbumState {
  final bool isLoading;
  final String? errorMessage;
  final String albumName;
  final String albumImageUrl;
  final List<SongModel> songs;

  const AlbumState({
    this.isLoading = false,
    this.errorMessage,
    this.albumName = "",
    this.albumImageUrl = "",
    this.songs = const [],
  });

  AlbumState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? albumName,
    String? albumImageUrl,
    List<SongModel>? songs,
  }) {
    return AlbumState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      albumName: albumName ?? this.albumName,
      albumImageUrl: albumImageUrl ?? this.albumImageUrl,
      songs: songs ?? this.songs,
    );
  }
}

class AlbumNotifier extends StateNotifier<AlbumState> {
  AlbumNotifier() : super(const AlbumState());

  final AlbumService _service = AlbumService();

  Future<void> loadAlbum(String albumId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await _service.getAlbumDetails(albumId);

    if (result == null) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Failed to load album",
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        albumName: result["albumName"],
        albumImageUrl: result["albumImageUrl"],
        songs: result["songs"],
      );
    }
  }
}

final albumProvider = StateNotifierProvider<AlbumNotifier, AlbumState>(
  (ref) => AlbumNotifier(),
);
