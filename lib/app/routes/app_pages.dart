import 'package:get/get.dart';

import 'package:movies_db/app/modules/home/bindings/home_binding.dart';
import 'package:movies_db/app/modules/home/views/home_view.dart';
import 'package:movies_db/app/modules/movie_details/bindings/movie_details_binding.dart';
import 'package:movies_db/app/modules/movie_details/views/movie_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
        name: _Paths.MOVIE_DETAILS,
        page: () => MovieDetailsView(),
        binding: MovieDetailsBinding(),
        arguments: Get.arguments),
  ];
}
