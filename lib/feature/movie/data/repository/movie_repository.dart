import 'package:bpjs_test/core/client/client.dart';
import 'package:bpjs_test/core/common/endpoint.dart';
import 'package:bpjs_test/core/common/logger.dart';
import 'package:bpjs_test/feature/movie/data/model/moviedb_response.dart';
import 'package:dio/dio.dart';

class MovieRepository {
  Dio dio = Client().dio;
  late Response response;

  // get now playing
  Future<MovieDBResponse> getPopularMovie(int page) async {
    Logger.print('--- MovieRepository @getPopularMovie : ---');
    try {
      var endPoint = Endpoint.popular;
      var param = {"page": page};

      response = await dio.get(
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
