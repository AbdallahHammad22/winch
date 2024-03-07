import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:winch/controllers/app_style/sizing.dart';
class AMap extends StatefulWidget {
  
  final List<LatLng> marks;
  final LatLng cameraPosition;
  final LatLng startLocation;
  final LatLng endLocation;
  final LatLng initialMark;

  const AMap({
    Key key,
    this.marks,
    this.cameraPosition,
    this.endLocation,
    this.startLocation,
    this.initialMark
  }) : super(key: key);

  @override
  _AMapState createState() => _AMapState();
}

class _AMapState extends State<AMap> {
  GoogleMapController _googleMapController;
  BitmapDescriptor userMark;
  BitmapDescriptor targetMark;
  List<Marker> markers = [];
  @override
  void initState() {
    super.initState();
    if(widget.marks != null)
    markers.addAll(
        List.generate(
          widget.marks.length,
              (index) => Marker(
            markerId: MarkerId("mark $index"),
            position: widget.marks[index],
          ),
        )
    );

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 68)), 'assets/images/map_mark.png')
        .then((mark) {
      userMark = mark;
      targetMark = mark;
      print("user_location --------------------------");
      setState(() {});
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if(widget.cameraPosition != null && _googleMapController != null){
      _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: widget.cameraPosition,
                zoom: 14
            ),
          )
      );
    }

    if(widget.initialMark != null){
      Marker _mark = Marker(
        markerId: MarkerId("user_location"),
        position: widget.initialMark,
        icon: userMark,
      );
      markers.add(_mark);
    }

    if(widget.startLocation != null){
      Marker _mark = Marker(
        markerId: MarkerId("user_location"),
        position: widget.startLocation ?? LatLng(0, 0),
        icon: userMark,
      );
      if(markers.length != 0){
        if(markers[0].markerId != MarkerId("user_location")){
          markers.insert(0, _mark);
        } else {
          markers.removeAt(0);
          markers.insert(0, _mark);
        }
      }else{
        markers.insert(0, _mark);
      }

    }

    if(widget.endLocation != null){
      Marker _mark = Marker(
        markerId: MarkerId("target_location"),
        position: widget.endLocation ?? LatLng(0, 0),
        icon: targetMark,
      );
      if(markers.length != 0){
        if(markers.last.markerId != MarkerId("target_location")){
          markers.add(_mark);
        }else{
          markers.removeLast();
          markers.add(_mark);
        }
      }else{
        markers.add(_mark);
      }

    }
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: widget.initialMark ?? LatLng(26.8206,30.8025), // egypt location
        zoom: widget.initialMark == null ? 6 : 14,
      ),
      markers: markers != null ? Set<Marker>.from(markers) : null,
      onMapCreated: (GoogleMapController controller) {
        _googleMapController = controller;
      },
      //polylines: ,
    );
  }

  animateCamera(){
    // Define two position variables
    LatLng _northeastCoordinates;
    LatLng _southwestCoordinates;

    // Calculating to check that
    // southwest coordinate <= northeast coordinate
    if (widget.startLocation.latitude <= widget.endLocation.latitude) {
      _southwestCoordinates = widget.startLocation;
      _northeastCoordinates = widget.endLocation;
    } else {
      _southwestCoordinates = widget.endLocation;
      _northeastCoordinates = widget.startLocation;
    }

    // Accommodate the two locations within the
    // camera view of the map
    _googleMapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: _northeastCoordinates,
          southwest: _southwestCoordinates,
        ),
        (_northeastCoordinates.latitude - _southwestCoordinates.latitude).abs() + 20, // padding
      ),
    );
  }
}
