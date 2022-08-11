import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:movies_db/app/routes/app_pages.dart';
import 'package:movies_db/app/widgets/movie_card.dart';
import 'package:movies_db/app/widgets/star_widget.dart';
import 'package:movies_db/core/constants/colors.dart';

import '../../../../core/constants/strings.dart';
import '../controllers/movie_details_controller.dart';

class MovieDetailsView extends GetView<MovieDetailsController> {
  @override
  final controller = Get.put(MovieDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() => SingleChildScrollView(
              child: controller.isLoading.value
                  ? Container(
                      height: Get.height,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: Get.height,
                              child: ShaderMask(
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              StringConstants.imageBaseUrl +
                                                  controller.moviesDetailList
                                                      .value.posterPath!),
                                          fit: BoxFit.fill)),
                                ),
                                shaderCallback: (bounds) {
                                  return LinearGradient(
                                    colors: [
                                      Colors.white,
                                      Color(0xFF1B1C2A),
                                      AppColors.background,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ).createShader(bounds);
                                },
                              ),
                            ),
                            detailsContainer(context),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(
                                    Icons.arrow_back_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          color: AppColors.background,
                          child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Container();
                              }),
                        )
                      ],
                    ),
            )),
      ),
    );
  }

  detailsContainer(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Get.height * 0.3),
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.movieDetails.title!,
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  controller.movieDetails.releaseDate!.split('-')[0] + " ",
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textLight,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    radius: 2,
                    backgroundColor: AppColors.grey20,
                  ),
                ),
                Text(
                  controller.genreList.join(' / '),
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textLight,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    radius: 2,
                    backgroundColor: AppColors.grey20,
                  ),
                ),
                Text(
                  controller.movieDuration,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textLight,
                      ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.transparent,
          ),
          Text(
            controller.movieDetails.overview!,
            style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
            textAlign: TextAlign.justify,
          ),
          Divider(
            color: Colors.transparent,
          ),
          RatingBarWithValue(
              value:
                  (controller.movieDetails.popularity!.toInt() / 20).floor()),
          SizedBox(
            height: Get.height * 0.05,
          ),
          Visibility(
            visible: controller.movieList.isNotEmpty,
            child: Text(
              "Also trending",
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
              textAlign: TextAlign.justify,
            ),
          ),
          Divider(
            color: Colors.transparent,
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.movieList.length,
            itemBuilder: (context, index) {
              return MoviesCard(movieList: controller.movieList[index]);
            },
            separatorBuilder: (context, index) {
              return Divider(
                color: Colors.transparent,
              );
            },
          )
        ],
      ),
    );
  }
}
