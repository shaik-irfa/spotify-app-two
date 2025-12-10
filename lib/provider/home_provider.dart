import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/home_service.dart';
import '../models/playlist_model.dart';
import '../models/category_model.dart';
import '../models/album_model.dart';

class HomeState {
  bool isLoading;
  String? errorMessage;
  List<Playlist> playlists;
  List<CategoryModel> categories;
  List<AlbumModel> albums;

  HomeState({
    this.isLoading = false,
    this.errorMessage,
    this.playlists = const [],
    this.categories = const [],
    this.albums = const [],
  });
}

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(HomeState());

  final HomeService _homeService = HomeService();

  Future<void> fetchHomeData() async {
    state = HomeState(isLoading: true);

    try {
      final featuredData = await _homeService.getFeaturedPlaylists();
      final categoriesData = await _homeService.getCategories();
      final newReleasesData = await _homeService.getNewReleases();

      state = HomeState(
        isLoading: false,
        playlists: featuredData,
        categories: categoriesData,
        albums: newReleasesData,
      );
    } catch (e) {
      state = HomeState(
        isLoading: false,
        errorMessage: "Something went wrong. Please try again.",
      );
    }
  }
}

// Provider for HomeScreen to read
final homeProvider =
    StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});
