import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
class ARateBar extends StatelessWidget {

  final double starsNumber;
  final double maxRating;
  final double minRating;
  final double itemSize;
  final bool tapOnlyMode;
  final EdgeInsets itemPadding;
  final Function(double) onRatingUpdate;
  const ARateBar({
    Key key,
    this.starsNumber,
    this.itemSize = 16,
    this.maxRating = 5,
    this.minRating = .5,
    this.onRatingUpdate,
    this.tapOnlyMode = true,
    this.itemPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return starsNumber == -1
    ? SizedBox.shrink()
    : RatingBar(
      itemSize: itemSize * AStyling.getScaleFactor(context),
      tapOnlyMode: tapOnlyMode,
      ignoreGestures: onRatingUpdate == null,
      allowHalfRating:  true,
      initialRating: starsNumber,
      updateOnDrag: true,
      minRating: minRating,
      maxRating: maxRating,
      direction: Axis.horizontal,
      //allowHalfRating: true,
      itemCount: 5,
      //glowColor: Colors.grey,
      glow: false,
      itemPadding: itemPadding ?? EdgeInsets.symmetric(horizontal: 2),
      ratingWidget: RatingWidget(
        full: Icon(FontAwesomeIcons.solidStar, color: AColors.yellow,),
        half: Icon(FontAwesomeIcons.starHalfAlt, color: AColors.yellow,),
        empty: Icon(FontAwesomeIcons.star, color: AColors.yellow,),
      ),
      onRatingUpdate: onRatingUpdate,
    );
  }
}
