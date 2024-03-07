import 'package:flutter/material.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/user_vehicle.dart';
import 'package:winch/models/winch_request.dart';
import 'package:winch/widgets/loaders/no_item_found.dart';
import 'package:winch/widgets/user_vehicles/user_vehicles_item.dart';
import 'package:winch/widgets/winch_requests/winch_request_item.dart';

class WinchRequestsList extends StatelessWidget {

  final List<WinchRequest> winchRequests;
  final Function(WinchRequest) onPressed;

  const WinchRequestsList({
    Key key,
    this.winchRequests,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    if(winchRequests.length == 0)
      return NoItemFound(
        message: _subtitle.noWynchRequestsFound,
      );

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 38,vertical: 32),
      children: List.generate(
          winchRequests.length,
          (index) => WinchRequestItem(
            winchRequest: winchRequests[index],
            onPressed: onPressed,
          )
      ),
    );
  }
}
