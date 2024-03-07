import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/notification/notification_manger.dart';
import 'package:winch/controllers/providers/widgets/land_page_provider.dart';
import 'package:winch/models/app_notification.dart';
import 'package:winch/pages/login.dart';

class SplashPage extends StatefulWidget {
  static const String id = "Splash";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  Screen _screenParameter;
  LandPageProvider _landPageProvider;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
    Future.delayed(const Duration(milliseconds: 2500), () {
      Navigator.pushNamed(context, Login.id,arguments:null );
    });
  }

  @override
  Widget build(BuildContext context) {
    _landPageProvider = Provider.of<LandPageProvider>(context);
    return Scaffold(
      body: Container(
        color: Theme.of(context).accentColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FlareActor(
            "assets/flares/wynch_splash.flr",
            alignment: Alignment.center,
            fit: BoxFit.scaleDown,
            animation: "splash",
        ),
      ),
    );
  }
}
