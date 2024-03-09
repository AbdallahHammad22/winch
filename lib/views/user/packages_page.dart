import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/packages_provider.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/models/package.dart';
import 'package:winch/models/subscription.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/views/packages/packages_list.dart';
import 'package:winch/views/subscription/make_subscription.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';
class PackagesPage extends StatefulWidget {
  static final String id = "packages";
  @override
  _PackagesPageState createState() => _PackagesPageState();
}

class _PackagesPageState extends State<PackagesPage> {
  UserProvider _userProvider;
  PackagesProvider _packagesProvider;
  String _language;
  Subtitle _subtitle;
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _packagesProvider = Provider.of<PackagesProvider>(context);

    _language = WinchLocalization.of(context).locale.languageCode;
    _subtitle = WinchLocalization.of(context).subtitle;
    return LoadingManager(
      isLoading: _packagesProvider.isLoading,
      stateCode: _packagesProvider.stateCode,
      isFailedLoading: _packagesProvider.packages == null,
      onRefresh: () async {
        _packagesProvider.reset();
        await _packagesProvider.getPackages(
            token: _userProvider.userDate.token,
          language: _language
        );
      },
      child: PackagesList(
        packages: _packagesProvider.packages,
        onItemPressed: (package){
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_)=> MakeSubscription(
                  subscription: Subscription(
                    package: package
                  ),
                )
            )
          );
        },
      ),
    );
  }
}
