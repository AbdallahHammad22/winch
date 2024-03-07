import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/winch_request.dart';
import 'package:winch/pages/requests/create_winch_request.dart';
import 'package:winch/widgets/buttons/app_icon_button_3.dart';
import 'package:winch/widgets/loaders/app_loading.dart';
import 'package:winch/widgets/maps/Alocation_picker.dart';
import 'package:winch/widgets/maps/app_map.dart';
class MakeRequestPage extends StatefulWidget {
  static final String id = "make-request";
  @override
  _MakeRequestPageState createState() => _MakeRequestPageState();
}

class _MakeRequestPageState extends State<MakeRequestPage> {
  String _userLocationLabel;
  String _targetLocationLabel;
  LatLng _startLocation;
  LatLng _endLocation;
  LatLng _cameraPosition;
  Subtitle _subtitle;

  @override
  Widget build(BuildContext context) {
    _subtitle = WinchLocalization.of(context).subtitle;
    return Scaffold(
      //backgroundColor: Theme.of(context).accentColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: AMap(
                cameraPosition: _cameraPosition,
                startLocation: _startLocation,
                endLocation: _endLocation,
              ),
            ),
            Container(
              color: AColors.black,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ALocationPicker(
                        label: _userLocationLabel ?? _subtitle.whereAreYou,
                        onPick: (latLng,address){
                          _startLocation = latLng;
                          _userLocationLabel = address;
                          _cameraPosition = _startLocation;
                          setState(() {});
                        },
                      ),
                      AIconButton3(
                        iconData: Icons.gps_fixed,
                        onPressed: () async {
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
                                  contentPadding: EdgeInsets.zero,
                                  content: SizedBox(
                                      height: MediaQuery.of(context).size.height/5,
                                      child: ALoading()
                                  ),
                                );
                              }
                          );
                          LocationData _locationData = await location.getLocation();
                          _startLocation = LatLng(
                              _locationData.latitude,
                              _locationData.longitude
                          );
                          _userLocationLabel = _subtitle.myLocation;
                          Navigator.of(context).pop();
                          _cameraPosition = _startLocation;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ALocationPicker(
                        label: _targetLocationLabel ?? _subtitle.whereToGo,
                        onPick: (latLng, address){
                          _endLocation = latLng;
                          _targetLocationLabel = address;
                          _cameraPosition = _endLocation;
                          setState(() {});
                        },
                      ),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 400),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: Visibility(
                          replacement: SizedBox(width: 50,),
                          visible: _endLocation != null && _startLocation != null,
                          child: AIconButton3(
                            iconData: Icons.arrow_forward,
                            onPressed: (){
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_)=> CreateWinchRequest(
                                      winchRequest: WinchRequest(
                                        startLocation: _startLocation,
                                        endLocation: _endLocation,
                                      ),
                                    )
                                  )
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
