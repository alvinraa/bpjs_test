import 'package:flutter_test/flutter_test.dart';
import 'package:bpjs_test/feature/movie/data/model/movie_model.dart';

void main() async {
  group('MovieModel', () {
    // Define a sample JSON to use in tests
    final Map<String, dynamic> sampleJson = {
      "adult": false,
      "backdrop_path": "/sample_backdrop_path.jpg",
      "genre_ids": [28, 12, 16],
      "id": 12345,
      "original_language": "en",
      "original_title": "Sample Movie",
      "overview": "This is a sample movie overview.",
      "popularity": 150.0,
      "poster_path": "/sample_poster_path.jpg",
      "release_date": "2024-01-01",
      "title": "Sample Movie Title",
      "video": false,
      "vote_average": 8.7,
      "vote_count": 2000,
    };

    // Test for fromJson() method
    test('fromJson() should correctly convert a JSON to MovieModel', () {
      // Call the fromJson method with the sample JSON
      final movie = MovieModel.fromJson(sampleJson);

      // Verify all fields are correctly parsed
      expect(movie.adult, false);
      expect(movie.backdropPath, "/sample_backdrop_path.jpg");
      expect(movie.genreIds, [28, 12, 16]);
      expect(movie.id, 12345);
      expect(movie.originalLanguage, "en");
      expect(movie.originalTitle, "Sample Movie");
      expect(movie.overview, "This is a sample movie overview.");
      expect(movie.popularity, 150.0);
      expect(movie.posterPath, "/sample_poster_path.jpg");
      expect(movie.releaseDate, DateTime(2024, 1, 1));
      expect(movie.title, "Sample Movie Title");
      expect(movie.video, false);
      expect(movie.voteAverage, 8.7);
      expect(movie.voteCount, 2000);
    });

    // Test for toJson() method
    test('toJson() should correctly convert a MovieModel to JSON', () {
      // Create a MovieModel object with predefined values
      final movie = MovieModel(
        adult: false,
        backdropPath: "/sample_backdrop_path.jpg",
        genreIds: [28, 12, 16],
        id: 12345,
        originalLanguage: "en",
        originalTitle: "Sample Movie",
        overview: "This is a sample movie overview.",
        popularity: 150.0,
        posterPath: "/sample_poster_path.jpg",
        releaseDate: DateTime(2024, 1, 1),
        title: "Sample Movie Title",
        video: false,
        voteAverage: 8.7,
        voteCount: 2000,
      );

      // Convert the MovieModel to JSON using the toJson() method
      final json = movie.toJson();

      // Verify the JSON structure matches the sample JSON
      expect(json['adult'], false);
      expect(json['backdrop_path'], "/sample_backdrop_path.jpg");
      expect(json['genre_ids'], [28, 12, 16]);
      expect(json['id'], 12345);
      expect(json['original_language'], "en");
      expect(json['original_title'], "Sample Movie");
      expect(json['overview'], "This is a sample movie overview.");
      expect(json['popularity'], 150.0);
      expect(json['poster_path'], "/sample_poster_path.jpg");
      expect(json['release_date'], "2024-01-01");
      expect(json['title'], "Sample Movie Title");
      expect(json['video'], false);
      expect(json['vote_average'], 8.7);
      expect(json['vote_count'], 2000);
    });

    // Optional: Test handling of null values in fromJson()
    test('fromJson() should handle null values correctly', () {
      // Sample JSON with some null values
      final Map<String, dynamic> jsonWithNulls = {
        "adult": null,
        "backdrop_path": null,
        "genre_ids": null,
        "id": null,
        "original_language": null,
        "original_title": null,
        "overview": null,
        "popularity": null,
        "poster_path": null,
        "release_date": null,
        "title": null,
        "video": null,
        "vote_average": null,
        "vote_count": null,
      };

      // Create a MovieModel object from the JSON
      final movie = MovieModel.fromJson(jsonWithNulls);

      // Check that all fields are null
      expect(movie.adult, null);
      expect(movie.backdropPath, null);
      expect(movie.genreIds, []);
      expect(movie.id, null);
      expect(movie.originalLanguage, null);
      expect(movie.originalTitle, null);
      expect(movie.overview, null);
      expect(movie.popularity, null);
      expect(movie.posterPath, null);
      expect(movie.releaseDate, null);
      expect(movie.title, null);
      expect(movie.video, null);
      expect(movie.voteAverage, null);
      expect(movie.voteCount, null);
    });
  });
}
