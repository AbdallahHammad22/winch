import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/controllers/providers/api/user_vehicles_provider.dart';
import 'package:winch/controllers/providers/widgets/land_page_provider.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/views/user_vechiles/user_vehicles_list.dart';
import 'package:winch/views/vehicles/add_vehicle.dart';
import 'package:winch/views/vehicles/edit_vehicle.dart';
import 'package:winch/views/vehicles/vehicle_details.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/buttons/app_out_line_button.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';
import 'package:winch/widgets/titles/app_title.dart';
class UserCars extends StatefulWidget {
  static final String id = "user-cars";
  @override
  _UserCarsState createState() => _UserCarsState();
}

class _UserCarsState extends State<UserCars> {
  UserProvider _userProvider;
  UserVehiclesProvider _userVehiclesProvider;
  LandPageProvider _landPageProvider;
  Size _size;
  String _language;
  Subtitle _subtitle;
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _userVehiclesProvider = Provider.of<UserVehiclesProvider>(context);
    _landPageProvider = Provider.of<LandPageProvider>(context);
    _size = MediaQuery.of(context).size;
    _language = WinchLocalization.of(context).locale.languageCode;
    _subtitle = WinchLocalization.of(context).subtitle;
    return Scaffold(
      body: LoadingManager(
        isLoading: _userVehiclesProvider.isLoading,
        isFailedLoading: _userVehiclesProvider.userVehicles == null,
        stateCode: _userVehiclesProvider.stateCode,
        onRefresh: () async {
          _userVehiclesProvider.reset();
          await _userVehiclesProvider.getUserVehicles(
              token: _userProvider.userDate.token,
              userId: _userProvider.userDate.id,
            language: _language
          );
        },
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: 32,),
                  Text(
                    _subtitle.myCars,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textScaleFactor: AStyling.getScaleFactor(context),
                  ),
                  SizedBox(
                    width: 100 * AStyling.getScaleFactor(context),
                    child: Divider(
                      color: Theme.of(context).accentColor,
                      thickness: 3,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: UserVehiclesList(
                userVehicle: _userVehiclesProvider.userVehicles,
                onPressed: (vehicle){
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => VehicleDetails(
                            userVehicle: vehicle,
                          )
                      )
                  );
                },
                onEdit: (vehicle){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => EditVehicle(
                          userVehicle: vehicle,
                        )
                    )
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: _size.width /3,
                    child: AOutLineButton(
                      text: _subtitle.back,
                      borderColor: Theme.of(context).textTheme.subtitle1.color,
                      onPressed: (){
                        _landPageProvider.reset();
                      },
                    ),
                  ),
                  SizedBox(),
                  SizedBox(
                    width: _size.width /3,
                    child: AButton(
                      text: _subtitle.addACar,
                      onPressed: (){
                        Navigator.of(context).pushNamed(AddVehicle.id);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }
}
