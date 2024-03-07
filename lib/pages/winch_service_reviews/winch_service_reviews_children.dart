import 'package:flutter/material.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/package.dart';
import 'package:winch/models/review.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/widgets/loaders/no_item_found.dart';
import 'package:winch/widgets/packages/package_item.dart';
import 'package:winch/widgets/service_reviews/winch_service_review_item.dart';

class WinchServiceReviewsChildren extends StatelessWidget {

  final List<WinchServiceReview> reviews;

  const WinchServiceReviewsChildren({Key key, this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    if(reviews?.length == 0)
      return NoItemFound(
        message: "no reviews found",
      );

    return Column(
      children: List.generate(
        reviews.length,
        (index) =>
            WinchServiceReviewItem(
              review: reviews[index],
            )
      ),
    );
  }
}
