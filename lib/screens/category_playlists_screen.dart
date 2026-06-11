import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/category_provider.dart';
import 'playlist_detail_screen.dart';
import '../widgets/mini_player.dart';
import '../widgets/music_image.dart';

class CategoryPlaylistsScreen extends ConsumerStatefulWidget {
  final String categoryId;
  final String categoryName;
  final String categoryImageUrl;

  const CategoryPlaylistsScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.categoryImageUrl,
  });

  @override
  ConsumerState<CategoryPlaylistsScreen> createState() =>
      _CategoryPlaylistsScreenState();
}

class _CategoryPlaylistsScreenState
    extends ConsumerState<CategoryPlaylistsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(categoryProvider.notifier).loadCategoryPlaylists(
            categoryId: widget.categoryId,
            categoryName: widget.categoryName,
            categoryImageUrl: widget.categoryImageUrl,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoryProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.categoryName,
            style: const TextStyle(color: Colors.white)),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.green))
          : state.errorMessage != null
              ? Center(
                  child: Text(
                    state.errorMessage!,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.playlists.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 18,
                    childAspectRatio: 0.78,
                  ),
                  itemBuilder: (_, index) {
                    final playlist = state.playlists[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PlaylistDetailScreen(
                              playlistId: playlist["id"]!,
                              playlistName: playlist["name"]!,
                              playlistImageUrl: playlist["image"]!,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: MusicImage(
                              imageUrl: playlist["image"]!,
                              height: 130,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            playlist["name"]!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            "${playlist["totalTracks"]} tracks",
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

      // ⬇ GLOBAL MINI PLAYER ADDED
      bottomNavigationBar: const MiniPlayer(),
    );
  }
}
