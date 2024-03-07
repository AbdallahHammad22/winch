import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/models/review.dart';
import 'package:winch/widgets/titles/app_sub_title.dart';

import 'app_rate_bar.dart';
class WinchServiceReviewItem extends StatelessWidget {
  final WinchServiceReview review;

  const WinchServiceReviewItem({Key key, this.review}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 48,
          vertical: 4
      ),
      padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8
      ),
      decoration: BoxDecoration(
          color: AColors.lightGrey,
          boxShadow: [
            BoxShadow(
                color: AColors.grey,
                blurRadius: 10,
                offset: Offset(0,5)
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  DateFormat.yMd().add_jm().format(review.date),
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                  ),
                  textScaleFactor: AStyling.getScaleFactor(context),
                ),
              ),
              ARateBar(starsNumber: review.rate,)
            ],
          ),
          review.comment == null ? SizedBox.shrink() :
          Padding(
            padding: EdgeInsets.only(top: 8 * AStyling.getScaleFactor(context)),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    review.comment,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    ),
                    textScaleFactor: AStyling.getScaleFactor(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
