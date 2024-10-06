import 'package:bpjs_test/core/client/client.dart';
import 'package:bpjs_test/core/common/endpoint.dart';
import 'package:bpjs_test/core/common/logger.dart';
import 'package:bpjs_test/feature/movie/data/model/moviedb_response.dart';
import 'package:dio/dio.dart';

abstract class IMovieRepository {
  Future<MovieDBResponse> getPopularMovie(int page);
}

class MovieRepository implements IMovieRepository {
  Dio client = Client().dio;
  late Response response;

  // get now playing
  @override
  Future<MovieDBResponse> getPopularMovie(int page) async {
    Logger.print('--- MovieRepository @getPopularMovie : ---');
    try {
      var endPoint = Endpoint.popular;
      var param = {"page": page};

      response = await client.get(
        endPoint,
        queryParameters: param,
      );

      var responseData = response.data;
      MovieDBResponse result = MovieDBResponse.fromJson(responseData);

      return result;
    } on DioException catch (e) {
      throw e.message ?? '-';
    }
  }
}
