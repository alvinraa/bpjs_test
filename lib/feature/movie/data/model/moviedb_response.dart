import 'dart:convert';
import 'package:bpjs_test/feature/movie/data/model/movie_model.dart';

MovieDBResponse movieDBResponseFromJson(String str) =>
    MovieDBResponse.fromJson(json.decode(str));

String movieDBResponseToJson(MovieDBResponse data) =>
    json.encode(data.toJson());

class MovieDBResponse {
  Dates? dates;
  int? page;
  List<MovieModel>? results;
  int? totalPages;
  int? totalResults;

  MovieDBResponse({
    this.dates,
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MovieDBResponse.fromJson(Map<String, dynamic> json) =>
      MovieDBResponse(
        dates: json["dates"] == null ? null : Dates.fromJson(json["dates"]),
        page: json["page"],
        results: json["results"] == null
            ? []
            : List<MovieModel>.from(
                json["results"]!.map((x) => MovieModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "dates": dates?.toJson(),
        "page": page,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Dates {
  DateTime? maximum;
  DateTime? minimum;

  Dates({
    this.maximum,
    this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: json["maximum"] == null || json["maximum"] == ''
            ? null
            : DateTime.parse(json["maximum"]),
        minimum: json["minimum"] == null || json["minimum"] == ''
            ? null
            : DateTime.parse(json["minimum"]),
      );

  Map<String, dynamic> toJson() => {
        "maximum": maximum?.toIso8601String(),
        "minimum": minimum?.toIso8601String(),
      };
}
