import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

import 'package:movies_db/app/modules/home/controllers/home_controller.dart';
import 'package:movies_db/app/modules/home/movie_model.dart';
import 'package:movies_db/app/widgets/shimmer_helper.dart';
import 'package:movies_db/app/widgets/star_widget.dart';
import 'package:movies_db/core/constants/colors.dart';
import 'package:movies_db/core/constants/strings.dart';
import 'package:movies_db/generated/assets.dart';

class MoviesCard extends GetView<HomeController> {
  MoviesCard({this.isTopMovie = false, required this.movieList});

  final bool isTopMovie;
  final Results movieList;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: AppColors.cardBackground,
        height: Get.height * 0.25,
        child: Row(
          children: [
            Container(
              width: Get.width * 0.4,
              height: double.maxFinite,
              child: CachedNetworkImage(
                imageUrl: StringConstants.imageBaseUrl + movieList.posterPath!,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    ShimmerHelper.buildBasicShimmer(
                        height: Get.height * 0.25,
                        horizontalPadding: 0,
                        verticalPadding: 0),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isTopMovie) ...[
                    Row(
                      children: [
                        SizedBox.square(
                          dimension: 30,
                          child:
                              Image(image: AssetImage(Assets.assetsIcTopMovie)),
                        ),
                        VerticalDivider(),
                        Text("Top movie this week",
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                      ],
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                  ],
                  Text(
                    movieList.title!,
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 10,
                  ),
                  Text(
                      controller.getGenreName(movieList.genreIds!).isNotEmpty
                          ? controller
                              .getGenreName(
                                movieList.genreIds!,
                              )
                              .join(
                                ' / ',
                              )
                          : "Action",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: AppColors.textLight,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          )),
                  Divider(
                    color: Colors.transparent,
                    height: 5,
                  ),
                  Text(
                    movieList.releaseDate!.split('-')[0].toString(),
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          color: AppColors.textLight,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                  ),
                  Spacer(),
                  RatingBarWithValue(
                    value: (movieList.popularity!.toInt() / 20).floor(),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
