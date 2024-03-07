import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/packages_provider.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/controllers/providers/api/winch_requests_provider.dart';
import 'package:winch/models/package.dart';
import 'package:winch/models/subscription.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/pages/packages/packages_list.dart';
import 'package:winch/pages/requests/winch_request_details.dart';
import 'package:winch/pages/requests/winch_requests_list.dart';
import 'package:winch/pages/subscription/make_subscription.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';
class WinchRequestsPage extends StatefulWidget {
  static final String id = "wynch-requests";
  @override
  _WinchRequestsPageState createState() => _WinchRequestsPageState();
}

class _WinchRequestsPageState extends State<WinchRequestsPage> {
  UserProvider _userProvider;
  WinchRequestsProvider _winchRequestsProvider;
  String _language;
  Subtitle _subtitle;
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _winchRequestsProvider = Provider.of<WinchRequestsProvider>(context);
    _language = WinchLocalization.of(context).locale.languageCode;
    _subtitle = WinchLocalization.of(context).subtitle;
    return LoadingManager(
      isLoading: _winchRequestsProvider.isLoading,
      stateCode: _winchRequestsProvider.stateCode,
      isFailedLoading: _winchRequestsProvider.winchRequests == null,
      onRefresh: () async {
        _winchRequestsProvider.reset();
        await _winchRequestsProvider.getWinchRequests(
          token: _userProvider.userDate.token,
          userId: _userProvider.userDate.id,
          language: _language
        );
      },
      child: WinchRequestsList(
        winchRequests: _winchRequestsProvider.winchRequests,
        onPressed: (winchRequest){
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_)=> WinchRequestDetails(
                  winchRequest: winchRequest,
                )
            )
          );
        },
      ),
    );
  }
}
