import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'app_map.dart';
class ViewLocation extends StatelessWidget {
  final LatLng location;

  const ViewLocation({Key key, this.location}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32,vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
            AStyling.getBorderRadius(context)
        ),
        boxShadow: [
          AStyling.boxShadow,
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
            AStyling.getBorderRadius(context)
        ),
        child: AMap(
          initialMark: location,
        ),
      ),
    );
  }
}
