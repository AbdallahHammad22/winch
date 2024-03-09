import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/controllers/providers/api/user_vehicles_provider.dart';
import 'package:winch/controllers/providers/api/winch_requests_provider.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/user_vehicle.dart';
import 'package:winch/models/winch_request.dart';
import 'package:winch/views/requests/winch_request_details.dart';
import 'package:winch/views/vehicles/vehicle_details.dart';
import 'package:winch/widgets/loaders/app_loading.dart';
import 'package:winch/widgets/loaders/failed_loading.dart';
import 'package:winch/widgets/user_vehicles/user_vechicls_picker.dart';
class FutureWinchRequestDetails extends StatefulWidget {
  static final String id = "wynch-requests";

  @override
  _FutureWinchRequestDetailsState createState() => _FutureWinchRequestDetailsState();
}

class _FutureWinchRequestDetailsState extends State<FutureWinchRequestDetails> {

  UserProvider _userProvider;
  String _language;
  Subtitle _subtitle;
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _language = WinchLocalization.of(context).locale.languageCode;
    _subtitle = WinchLocalization.of(context).subtitle;
    String winchRequestId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: FutureBuilder<WinchRequest>(
        future: WinchRequestsProvider().getSingleWinchRequest(
          requestId: winchRequestId,
          token: _userProvider.userDate?.token,
          language: _language,
          subtitle: _subtitle
        ),
        builder: (BuildContext context, AsyncSnapshot<WinchRequest> snapshot){
          if(snapshot.hasError)
            return FailedLoading(
              message: snapshot.error.toString(),
              onReload: (){setState(() {});},
            );
          if(snapshot.hasData){
            return WinchRequestDetails(
              winchRequest: snapshot.data,
            );
          }
          return Center(child: ALoading());
        },
      ),
    );
  }
}
