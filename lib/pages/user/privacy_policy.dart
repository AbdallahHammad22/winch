import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/about_provider.dart';
import 'package:winch/controllers/providers/api/privacy_policy_provider.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/controllers/providers/widgets/land_page_provider.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/widgets/buttons/app_back_button.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';
import 'package:winch/widgets/titles/app_title.dart';
class PrivacyPolicy extends StatefulWidget {
  static final String id = "privacy-policy";
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  LandPageProvider _landPageProvider;
  UserProvider _userProvider;
  PrivacyPolicyProvider _privacyPolicyProvider;
  String language;
  Subtitle _subtitle;
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    _landPageProvider = Provider.of<LandPageProvider>(context);
    _privacyPolicyProvider = Provider.of<PrivacyPolicyProvider>(context);
    _userProvider = Provider.of<UserProvider>(context);
    language = WinchLocalization.of(context).locale.languageCode;
    _subtitle = WinchLocalization.of(context).subtitle;
    return LoadingManager(
      isLoading: _privacyPolicyProvider.isLoading,
      isFailedLoading: _privacyPolicyProvider.privacyPolicy == null,
      stateCode: _privacyPolicyProvider.stateCode,
      onRefresh: () async {
        _privacyPolicyProvider.reset();
        await _privacyPolicyProvider.getPrivacyPolicy(
            token: _userProvider.userDate.token,
            language: language
        );
      },
      child: ListView(
        children: [
          SizedBox(height: _height / 20,),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: _width/1.5,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 16,),
                      Expanded(
                        child: ABackButton(
                          onPressed: (){
                            _landPageProvider.reset();
                          },
                        ),
                      ),
                      ATitle(_subtitle.privacyPolicy),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                            color: Theme.of(context).accentColor,
                            thickness: 3,
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: _height / 28,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: _privacyPolicyProvider.privacyPolicy == null ? SizedBox.shrink() : Html(
                    data: _privacyPolicyProvider.privacyPolicy,
                    onLinkTap: (String url, RenderContext context, Map<String, String> attributes, element) {
                      launch(url);
                    },
                  )
                ),

              ],
            ),
          ),
          SizedBox(height: _height / 12,),
        ],
      ),
    );
  }
}
