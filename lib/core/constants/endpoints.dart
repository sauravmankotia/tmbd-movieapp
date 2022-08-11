import 'package:movies_db/core/constants/strings.dart';

class ApiEndpoints {
  static String topRatedUrl({page = 1}) {
    return '${StringConstants.baseUrl}/movie/top_rated?api_key=${StringConstants.apiKeyV3}&include_adult=false&page=$page';
  }

  static String movieDetailsUrl(int movieId) {
    return '${StringConstants.baseUrl}/movie/$movieId?api_key=${StringConstants.apiKeyV3}';
  }

  static String genresUrl() {
    return '${StringConstants.baseUrl}/genre/movie/list?api_key=${StringConstants.apiKeyV3}&language=en-US';
  }

  static String upcomingMoviesUrl(int page) {
    return '${StringConstants.baseUrl}'
        '/movie/upcoming?api_key='
        '${StringConstants.apiKeyV3}'
        '&include_adult=false';
  }
}
