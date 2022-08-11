import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants/colors.dart';

enum ShimmerShapeType { Rectangle, Square, Circle }

class ShimmerHelper {
  static Widget buildCircleShimmer({
    double radius = 40.0,
    bool showIcon = false,
  }) {
    return Material(
      shape: const CircleBorder(),
      color: showIcon
          ? Theme.of(Get.context!).secondaryHeaderColor
          : Theme.of(Get.context!).scaffoldBackgroundColor,
      elevation: 3,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Shimmer.fromColors(
        baseColor: showIcon
            ? Colors.transparent
            : Theme.of(Get.context!).secondaryHeaderColor,
        highlightColor: Theme.of(Get.context!).splashColor,
        child: Container(
          constraints: BoxConstraints(
            minHeight: 2.0 * radius,
            minWidth: 2.0 * radius,
            maxWidth: 2.0 * radius,
            maxHeight: 2.0 * radius,
          ),
          decoration: BoxDecoration(
            color: showIcon ? Colors.transparent : Colors.white,
            shape: BoxShape.circle,
          ),
          clipBehavior: Clip.hardEdge,
        ),
      ),
    );
  }

  static Widget buildBasicShimmer({
    double? height,
    double width = double.infinity,
    bool showIcon = false,
    double? horizontalPadding,
    double? verticalPadding,
    double? logoHeight,
    double? logoWidth,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? Get.width * 0.001,
        vertical: verticalPadding ?? Get.height * 0.01,
      ),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Shimmer.fromColors(
          baseColor: AppColors.cardBackground,
          highlightColor: AppColors.textLight,
          child: Container(
            height: height ?? 120,
            width: width,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildListShimmer({
    int itemCount = 10,
    double? height,
    double? width,
    bool sliverItem = false,
    bool showIcon = false,
    ShimmerShapeType shape = ShimmerShapeType.Rectangle,
  }) {
    return ListView.builder(
      itemCount: itemCount,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return shape == ShimmerShapeType.Circle
            ? ShimmerHelper.buildCircleShimmer()
            : Padding(
                padding: const EdgeInsets.only(
                  top: 0.0,
                  left: 16.0,
                  right: 16.0,
                  bottom: 16.0,
                ),
                child: Shimmer.fromColors(
                  baseColor: AppColors.background,
                  highlightColor: AppColors.textLight,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width ?? 150,
                        child: ShimmerHelper.buildBasicShimmer(
                          horizontalPadding: 0,
                          verticalPadding: 0,
                          height: height,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 12.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0),
                              ),
                              Container(
                                width: double.infinity,
                                height: 12.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: 40.0,
                                height: 12.0,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                width: 100.0,
                                height: 12.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ));
      },
    );
  }
}
