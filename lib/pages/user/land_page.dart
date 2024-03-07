import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/notification/notification_manger.dart';
import 'package:winch/controllers/providers/api/about_provider.dart';
import 'package:winch/controllers/providers/api/categories_provider.dart';
import 'package:winch/controllers/providers/api/packages_provider.dart';
import 'package:winch/controllers/providers/api/privacy_policy_provider.dart';
import 'package:winch/controllers/providers/api/terms_and_conditions_provider.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/controllers/providers/api/user_vehicles_provider.dart';
import 'package:winch/controllers/providers/settings/setting_provider.dart';
import 'package:winch/controllers/providers/widgets/land_page_provider.dart';
import 'package:winch/icons/winch_icons_icons.dart';
import 'package:winch/models/app_notification.dart';
import 'package:winch/models/drawer_item_data.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/user.dart';
import 'package:winch/models/user_vehicle.dart';
import 'package:winch/pages/user/contact_us.dart';
import 'package:winch/pages/user/make_request_page.dart';
import 'package:winch/pages/user/packages_page.dart';
import 'package:winch/pages/user/privacy_policy.dart';
import 'package:winch/pages/user/profile.dart';
import 'package:winch/pages/user/user_cars.dart';
import 'package:winch/pages/user/winch_requests_page.dart';
import 'package:winch/pages/user/wynch_intro_page.dart';
import 'package:winch/widgets/dialogs/dialog.dart';
import 'package:winch/widgets/drawer/drawer_item.dart';
import 'package:winch/widgets/titles/app_sub_title.dart';

import '../login.dart';
import 'about_us.dart';

class LandPage extends StatefulWidget {
  static final String id = "/land-page";
  final bool startInto;

  const LandPage({Key key, this.startInto = true}) : super(key: key);
  @override
  _LandPageState createState() => _LandPageState();
}

class _LandPageState extends State<LandPage> {
  LandPageProvider _landPageProvider;
  UserProvider _userProvider;
  SettingProvider _settingProvider;
  PackagesProvider _packagesProvider;
  UserVehiclesProvider _userVehiclesProvider;
  PrivacyPolicyProvider _privacyPolicyProvider;
  TermsAndConditionsProvider _termsAndConditionsProvider;
  CategoriesProvider _categoriesProvider;
  AboutProvider _aboutProvider;
  String _language;
  Subtitle _subtitle;
  List<DrawerItemData> items;
  bool _openIntro = false;

  getDrawerItem(Subtitle subtitle) {
    List<DrawerItemData> _items = [
      DrawerItemData(label: subtitle.packages, iconData: WinchIcons.favorite),
      DrawerItemData(
          label: subtitle.myCars, iconData: WinchIcons.car_of_hatchback_model),
      DrawerItemData(
          label: subtitle.makeRequest, iconData: WinchIcons.location),
      DrawerItemData(label: subtitle.requests, iconData: WinchIcons.refresh),
      DrawerItemData(label: subtitle.help, iconData: WinchIcons.phone),
      DrawerItemData(label: subtitle.privacyPolicy, iconData: Icons.policy),
      DrawerItemData(label: subtitle.aboutUs, iconData: WinchIcons.settings),
    ];
    return _items;
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static Future<dynamic> myBackgroundMessageHandler(
      RemoteMessage message) async {
    print("notification: $message");
    if (message.data?.isNotEmpty == true) {
      // Handle data message
      final dynamic data = message.data;
    }

    if (message.notification != null) {
      // Handle notification message
      final dynamic notification = message.notification;
    }

    // Or do other work.
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          print('Got a message whilst in the foreground!');
          print('Message data: ${message.data}');
          try {
            Map<String, dynamic> data = Map<String, dynamic>.from(message.data);
            AppNotification notification = AppNotification.fromJson(data);
            NotificationManger.showNotification(
                title: notification.title,
                subtext: notification.body,
                hashcode: DateTime.now().millisecond,
                payload: notification.screen?.toJson());
          } catch (error) {
            print(error);
          }
        });
        FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
          print('Got a message whilst in the foreground!');
          print('Message data: ${message.data}');
          try {
            Map<String, dynamic> data = Map<String, dynamic>.from(message.data);
            AppNotification notification = AppNotification.fromJson(data);
            _landPageProvider.goToPath(context, notification.screen);
          } catch (error) {
            print(error);
          }
        });
      }

      if (_openIntro) {
        Navigator.of(context).pushNamed(WynchIntroPage.id);
      }
      if (_userVehiclesProvider.userVehicles == null) {
        _userVehiclesProvider.reset();
        await _userVehiclesProvider.getUserVehicles(
            token: _userProvider.userDate.token,
            userId: _userProvider.userDate.id,
            language: _language);
        print(_userVehiclesProvider.checkIfSubscribe());
        if (!_openIntro && (!_userVehiclesProvider.checkIfSubscribe())) {
          bool goToPackage = await showDialog(
              context: context,
              builder: (_) => CupertinoAlertDialog(
                    title: Text(_subtitle.checkOutOurPackages),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(_subtitle.goToPackages),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                      ),
                      FlatButton(
                        child: Text(_subtitle.oneTimeRequest),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ],
                  ));
          if (goToPackage != true) return;
          _landPageProvider.index = 0;
        }
      }
    });

    NotificationManger.initialisation((payload) {
      if (payload != null) {
        _landPageProvider.goToPath(
            context, Screen.fromJson(json.decode(payload)));
      }
    }, (id, title, body, payload) async {
      if (payload != null) {
        _landPageProvider.goToPath(
            context, Screen.fromJson(json.decode(payload)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _openIntro = ModalRoute.of(context).settings.arguments ?? false;
    _landPageProvider = Provider.of<LandPageProvider>(context);
    _settingProvider = Provider.of<SettingProvider>(context);
    _userProvider = Provider.of<UserProvider>(context);
    _userVehiclesProvider = Provider.of<UserVehiclesProvider>(context);
    _packagesProvider = Provider.of<PackagesProvider>(context);
    _privacyPolicyProvider = Provider.of<PrivacyPolicyProvider>(context);
    _termsAndConditionsProvider =
        Provider.of<TermsAndConditionsProvider>(context);
    _categoriesProvider = Provider.of<CategoriesProvider>(context);
    _aboutProvider = Provider.of<AboutProvider>(context);
    _subtitle = WinchLocalization.of(context).subtitle;
    _language = WinchLocalization.of(context).locale.languageCode;
    items = getDrawerItem(_subtitle);
    return WillPopScope(
      onWillPop: () async {
        bool result = await showDialog(
            context: context,
            builder: (_) => AAlertDialog(
                  title: _subtitle.exit,
                  content: _subtitle.exitAlert,
                ));
        if (result == true) {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return true;
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AColors.black,
          title: Image(
            image: AssetImage("assets/images/logo_horizontal.png"),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Icon(
                Icons.menu,
                size: 40,
                color: AColors.yellow,
              ),
            )
          ],
        ),
        body: AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: Center(
            key: ValueKey(_landPageProvider.index),
            child: [
              PackagesPage(),
              UserCars(),
              MakeRequestPage(),
              WinchRequestsPage(),
              ContactUs(),
              PrivacyPolicy(),
              AboutUs(),
            ].elementAt(_landPageProvider.index),
          ),
        ),
        endDrawer: Drawer(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: AColors.grey,
                  ),
                  padding: EdgeInsets.zero,
                  child: MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.of(context).pushNamed(Profile.id);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 100 * AStyling.getScaleFactor(context),
                          width: 100 * AStyling.getScaleFactor(context),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).accentColor,
                                  width: 2),
                              shape: BoxShape.circle),
                          child: ClipOval(
                            child: Image(
                              image: AssetImage("assets/images/profile.png"),
                            ),
                          ),
                        ),
                        ASubTitle(_userProvider.userDate.name),
                      ],
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text(_subtitle.language),
                trailing: Switch(
                  value: _settingProvider.language.compareTo("ar") > 0,
                  onChanged: (isArabic) async {
                    if (isArabic)
                      await _settingProvider.setLanguage("en");
                    else
                      await _settingProvider.setLanguage("ar");

                    _aboutProvider.reset();
                    _categoriesProvider.reset();
                    _termsAndConditionsProvider.reset();
                    _privacyPolicyProvider.reset();
                    _packagesProvider.reset();
                    _userVehiclesProvider.reset();
                    print(isArabic);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: items.length,
                    itemBuilder: (context, itemIndex) {
                      return DrawerItem(
                        title: items[itemIndex].label,
                        icon: items[itemIndex].iconData,
                        isSelected: _landPageProvider.index == itemIndex,
                        onPressed: () {
                          _landPageProvider.index = itemIndex;
                          Navigator.of(context).pop();
                        },
                      );
                    }),
              ),
              DrawerItem(
                title: _subtitle.logout,
                icon: Icons.logout,
                isSelected: false,
                onPressed: () async {
                  bool result = await showDialog(
                      context: context,
                      builder: (_) => AAlertDialog(
                            title: _subtitle.logout,
                            content: _subtitle.logoutAlert,
                          ));
                  if (result == true) {
                    _userVehiclesProvider.reset();
                    _packagesProvider.reset();
                    _landPageProvider.reset();
                    _settingProvider.setUser(User());
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName(Login.id));
                  }
                },
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: AnimatedSwitcher(
          duration: Duration(milliseconds: 400),
          child: FloatingActionButton(
            heroTag: MakeRequestPage.id,
            key: ValueKey(_landPageProvider.index == 2),
            backgroundColor: _landPageProvider.index == 2
                ? AColors.white
                : Theme.of(context).accentColor,
            tooltip: _subtitle.makeRequest,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FaIcon(WinchIcons.location),
            ),
            onPressed: () {
              _landPageProvider.index = 2;
              setState(() {});
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 8,
          clipBehavior: Clip.antiAlias,
          shape: CircularNotchedRectangle(),
          child: Theme(
            data: Theme.of(context).copyWith(canvasColor: AColors.yellow),
            child: BottomNavigationBar(
              currentIndex:
                  _landPageProvider.index > 4 ? 2 : _landPageProvider.index,
              selectedItemColor: AColors.deepGrey,
              unselectedItemColor: AColors.black,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: FaIcon(WinchIcons.favorite,),
                    label: _subtitle.packages),
                BottomNavigationBarItem(
                    icon: FaIcon(
                      WinchIcons.car_of_hatchback_model,
                      size: 18,
                    ),
                    label: _subtitle.myCars),
                BottomNavigationBarItem(
                    icon: Icon(Icons.ac_unit_sharp, color: Colors.black),
                    label: ""),
                BottomNavigationBarItem(
                    icon: FaIcon(WinchIcons.refresh),
                    label: _subtitle.requests),
                BottomNavigationBarItem(
                    icon: FaIcon(WinchIcons.phone), label: _subtitle.help),
              ],
              onTap: (_pageIndex) {
                _landPageProvider.index = _pageIndex;
              },
            ),
          ),
        ),
      ),
    );
  }
}
