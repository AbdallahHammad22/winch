import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/widgets/loaders/app_loading.dart';

class ALocationPicker extends StatelessWidget {
  final LatLng initialLocation;
  final Function(LatLng,String) onPick;
  final String label;

  const ALocationPicker({Key key, this.label, this.initialLocation, this.onPick}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    return SizedBox(
      width: MediaQuery.of(context).size.width /1.4,
      child: MaterialButton(
        child: Row(
          children: [
            Text(
              label ?? _subtitle.pickLocation,
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                fontWeight: FontWeight.bold,
                color: AColors.deepGrey
              ),
              textScaleFactor: AStyling.getScaleFactor(context),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AStyling.getBorderRadius(context))
        ),
        elevation: 0,
        color: AColors.lightGrey,
        onPressed: () async {
          LocationData _locationData;
          // set it false for test purpose
          if (initialLocation == null && false) {

            Location location = new Location();

            bool _serviceEnabled;
            PermissionStatus _permissionGranted;

            _serviceEnabled = await location.serviceEnabled();
            if (!_serviceEnabled) {
              _serviceEnabled = await location.requestService();
              if (!_serviceEnabled) {
                return;
              }
            }

            _permissionGranted = await location.hasPermission();

            if (_permissionGranted == PermissionStatus.denied) {
              _permissionGranted = await location.requestPermission();
              if (_permissionGranted != PermissionStatus.granted) {
                return;
              }
            }
            showDialog(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    backgroundColor: Theme.of(context).accentColor,
                    content: SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                        child: ALoading()
                    ),
                  );
                }
            );
            _locationData = await location.getLocation();
            onPick(
                LatLng(
                _locationData.latitude,
                _locationData.longitude),
              _subtitle.myLocation
            );
            Navigator.of(context).pop();
          }
          LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
            // GoogleMap Key ....................................................................
              PlacePicker("AIzaSyAPhKrXFj52-N2Hu2Yyz79pn_GOy-e2-zM",
                displayLocation: initialLocation == null
                    ? LatLng(30.033333,31.233334)
                    : initialLocation,

              )
            )
          );
          print("----------------------------");
          print(result);
          onPick(result.latLng,result.name);
        },
      ),
    );
  }
}
