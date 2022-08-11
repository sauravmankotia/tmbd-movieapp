import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:movies_db/core/constants/colors.dart';

class RatingBarWithValue extends StatelessWidget {
  final int value;
  const RatingBarWithValue({
    this.value = 0,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xff252634),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconTheme(
              data: IconThemeData(
                color: Colors.amber,
              ),
              child: starsRow()),
          VerticalDivider(
            width: 5,
          ),
          Text(
            value < 5 ? '$value/5' : '5/5',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: AppColors.textLight,
                  fontSize: 12,
                ),
          )
        ],
      ),
    );
  }

  starsRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return index < value
            ? Icon(
                Icons.star,
                size: 12,
              )
            : Icon(
                Icons.star_border,
                size: 12,
              );
      }),
    );
  }
}
