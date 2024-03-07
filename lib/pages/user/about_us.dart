import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/about_provider.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/controllers/providers/widgets/land_page_provider.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/widgets/buttons/app_back_button.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';
import 'package:winch/widgets/titles/app_title.dart';
class AboutUs extends StatefulWidget {
  static final String id = "about-us";
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  LandPageProvider _landPageProvider;
  UserProvider _userProvider;
  AboutProvider _aboutProvider;
  String _language;
  Subtitle _subtitle;
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    _landPageProvider = Provider.of<LandPageProvider>(context);
    _aboutProvider = Provider.of<AboutProvider>(context);
    _userProvider = Provider.of<UserProvider>(context);
    _language = WinchLocalization.of(context).locale.languageCode;
    _subtitle = WinchLocalization.of(context).subtitle;
    return LoadingManager(
      isLoading: _aboutProvider.isLoading,
      isFailedLoading: _aboutProvider.aboutData == null,
      stateCode: _aboutProvider.stateCode,
      onRefresh: () async {
        _aboutProvider.reset();
        await _aboutProvider.getAboutData(
            token: _userProvider.userDate.token,
            language: _language
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
                      ATitle(_subtitle.aboutUs),
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
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _aboutProvider.aboutData?.bio ?? "",
                          style: Theme.of(context).textTheme.bodyText2,
                          textScaleFactor: AStyling.getScaleFactor(context),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                ATitle(_subtitle.vision),
                SizedBox(height: 4,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _aboutProvider.aboutData?.vision ?? "",
                          style: Theme.of(context).textTheme.bodyText2,
                          textScaleFactor: AStyling.getScaleFactor(context),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                ATitle(_subtitle.mission),
                SizedBox(height: 4,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _aboutProvider.aboutData?.mission ?? "",
                          style: Theme.of(context).textTheme.bodyText2,
                          textScaleFactor: AStyling.getScaleFactor(context),
                        ),
                      ),
                    ],
                  ),
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
