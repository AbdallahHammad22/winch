import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/views/user/land_page.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/titles/app_title.dart';
class WinchRequestDonePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child:Center(
                child: Text(
                  _subtitle.wynchTeamWillCallYou,
                  style: Theme.of(context).textTheme.headline5,
                  textScaleFactor: AStyling.getScaleFactor(context),
                ),
              ),
            ),
          ),
          Image(
            width: MediaQuery.of(context).size.width,
            image: AssetImage("assets/images/winch_request_done.png"),
            fit: BoxFit.fitWidth,
          ),
          Expanded(
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: AButton(
                  text: _subtitle.done,
                  onPressed: (){
                    Navigator.of(context).popUntil(ModalRoute.withName(LandPage.id));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
