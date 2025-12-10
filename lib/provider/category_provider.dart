import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/category_service.dart';

class CategoryState {
  final bool isLoading;
  final String? errorMessage;
  final String categoryName;
  final String categoryImageUrl;
  final List<Map<String, String>> playlists;

  const CategoryState({
    this.isLoading = false,
    this.errorMessage,
    this.categoryName = "",
    this.categoryImageUrl = "",
    this.playlists = const [],
  });

  CategoryState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? categoryName,
    String? categoryImageUrl,
    List<Map<String, String>>? playlists,
  }) {
    return CategoryState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      categoryName: categoryName ?? this.categoryName,
      categoryImageUrl: categoryImageUrl ?? this.categoryImageUrl,
      playlists: playlists ?? this.playlists,
    );
  }
}

class CategoryNotifier extends StateNotifier<CategoryState> {
  CategoryNotifier() : super(const CategoryState());

  final CategoryService _service = CategoryService();

  Future<void> loadCategoryPlaylists({
    required String categoryId,
    required String categoryName,
    required String categoryImageUrl,
  }) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      categoryName: categoryName,
      categoryImageUrl: categoryImageUrl,
    );

    final result = await _service.getCategoryPlaylists(categoryId);

    if (result.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: "Something went wrong. Try again",
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        playlists: result,
      );
    }
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, CategoryState>(
  (ref) => CategoryNotifier(),
);
