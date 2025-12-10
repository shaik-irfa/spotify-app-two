class ApiUrls {
  // Login
  static const String loginUrl = "https://apis.ccbp.in/login";

  // Home
  static const String featuredPlaylists =
      "https://apis2.ccbp.in/spotify-clone/featured-playlists";

  static const String categories =
      "https://apis2.ccbp.in/spotify-clone/categories";

  static const String newReleases =
      "https://apis2.ccbp.in/spotify-clone/new-releases";

  // Playlist details
  static String playlistDetails(String playlistId) =>
      "https://apis2.ccbp.in/spotify-clone/playlists-details/$playlistId";

  // Category playlists
  static String categoryPlaylists(String categoryId) =>
      "https://apis2.ccbp.in/spotify-clone/category-playlists/$categoryId";

  // Album details
  static String albumDetails(String albumId) =>
      "https://apis2.ccbp.in/spotify-clone/album-details/$albumId";
}
