import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/user_vehicles_provider.dart';
import 'package:winch/models/subscription.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/pages/subscription/make_subscription.dart';
import 'package:winch/pages/user/user_cars.dart';
import 'package:winch/pages/vehicles/add_vehicle.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/buttons/app_flat_button.dart';
import 'package:winch/widgets/from_top_cover.dart';
class WynchIntroPage extends StatefulWidget {
  static final String id = "wynch-intro-page";
  @override
  _WynchIntroPageState createState() => _WynchIntroPageState();
}

class _WynchIntroPageState extends State<WynchIntroPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  UserVehiclesProvider _userVehiclesProvider;
  bool _hasCars;
  bool _hasPackage;
  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this,length: 4);
  }
  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    _userVehiclesProvider = Provider.of<UserVehiclesProvider>(context);
    _hasCars = _userVehiclesProvider.userVehicles?.isNotEmpty == true;
    _hasPackage = _userVehiclesProvider.checkIfSubscribe();
    return Scaffold(
      body: Stack(
        children: [
          TabBarView(
            controller: _controller,
            children: [
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child:Center(
                        child: Text(
                          _subtitle.welcomeWord,
                          style: Theme.of(context).textTheme.headline5,
                          textScaleFactor: AStyling.getScaleFactor(context),
                        ),
                      ),
                    ),
                  ),
                  Image(
                    width: MediaQuery.of(context).size.width,
                    image: AssetImage("assets/images/home_for_member.png"),
                    fit: BoxFit.fitWidth,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child:Center(
                        child: Text(
                         _subtitle.welcomePhrase,
                          style: Theme.of(context).textTheme.headline6,
                          textScaleFactor: AStyling.getScaleFactor(context),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: AButton(
                          text: _subtitle.letsStart,
                          onPressed: (){
                            _controller.animateTo(_controller.index+1);
                            //Navigator.of(context).popUntil(ModalRoute.withName(LandPage.id));
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // add new car
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child:Center(
                        child: Text(
                          _subtitle.addCarWord,
                          style: Theme.of(context).textTheme.headline5,
                          textScaleFactor: AStyling.getScaleFactor(context),
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Image(
                        width: MediaQuery.of(context).size.width,
                        image: AssetImage("assets/images/add_new_car.png"),
                        fit: BoxFit.fitWidth,
                      ),
                      _hasCars ?
                      Padding(
                        padding: EdgeInsets.all(16.0 * AStyling.getScaleFactor(context)),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 72.0 * AStyling.getScaleFactor(context),
                        ),
                      ):SizedBox.shrink(),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child:Center(
                        child: Text(
                          _subtitle.addCarPhrase,
                          style: Theme.of(context).textTheme.headline6,
                          textScaleFactor: AStyling.getScaleFactor(context),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: AButton(
                          //color: _hasCars ? Colors.green : null,
                          text: _hasCars
                              ? _subtitle.continueWord
                              : _subtitle.addACar,
                          onPressed: () async {
                            if(_hasCars){
                              _controller.animateTo(_controller.index+1);
                            }else{
                              Navigator.of(context).pushNamed(AddVehicle.id);
                            }
                            //Navigator.of(context).popUntil(ModalRoute.withName(LandPage.id));
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child:Center(
                        child: Text(
                          _subtitle.subscribeWord,
                          style: Theme.of(context).textTheme.headline5,
                          textScaleFactor: AStyling.getScaleFactor(context),
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Image(
                        width: MediaQuery.of(context).size.width,
                        image: AssetImage("assets/images/home_for_all.png"),
                        fit: BoxFit.fitWidth,
                      ),
                      _hasPackage == true ?
                      Padding(
                        padding: EdgeInsets.all(16.0 * AStyling.getScaleFactor(context)),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 72.0 * AStyling.getScaleFactor(context),
                        ),
                      ):SizedBox.shrink(),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child:Center(
                        child: Text(
                          _subtitle.subscribePhrase,
                          style: Theme.of(context).textTheme.headline6,
                          textScaleFactor: AStyling.getScaleFactor(context),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: AButton(
                          text: _hasPackage == null
                              ? _subtitle.loading : _hasPackage ? _subtitle.continueWord : _subtitle.subscribe,
                          onPressed: _hasPackage == null ? null :(){
                            if(_hasPackage){
                              _controller.animateTo(_controller.index+1);
                            }else{
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_)=> MakeSubscription(
                                        subscription: Subscription(
                                          userVehicle: _userVehiclesProvider.userVehicles.first,
                                          popTo: WynchIntroPage.id
                                        ),
                                      )
                                  )
                              );
                            }
                            //Navigator.of(context).popUntil(ModalRoute.withName(LandPage.id));
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child:Center(
                        child: Text(
                          _subtitle.congratulationsWord,
                          style: Theme.of(context).textTheme.headline5,
                          textScaleFactor: AStyling.getScaleFactor(context),
                        ),
                      ),
                    ),
                  ),
                  Image(
                    width: MediaQuery.of(context).size.width,
                    image: AssetImage("assets/images/home_for_member.png"),
                    fit: BoxFit.fitWidth,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child:Center(
                        child: Text(
                          _subtitle.congratulationsPhrase,
                          style: Theme.of(context).textTheme.headline6,
                          textScaleFactor: AStyling.getScaleFactor(context),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: AButton(
                          text: _subtitle.done,
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]
          ),
          SafeArea(
            child: AFlatButton(
              text: _subtitle.skip,
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
