import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/categories_provider.dart';
import 'package:winch/controllers/providers/api/packages_provider.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/controllers/providers/api/user_vehicles_provider.dart';
import 'package:winch/models/category.dart';
import 'package:winch/models/package.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/user_vehicle.dart';
import 'package:winch/pages/categories/categories_list.dart';
import 'package:winch/pages/packages/packages_list.dart';
import 'package:winch/pages/user_vechiles/user_vehicles_list.dart';
import 'package:winch/widgets/app_text_field/app_text_form_field_3.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';

class UserVehiclesPicker extends StatefulWidget {
  static final String id = "/user-vehicles-picker";

  @override
  _UserVehiclesPickerState createState() => _UserVehiclesPickerState();
}

class _UserVehiclesPickerState extends State<UserVehiclesPicker>
  with TickerProviderStateMixin{
  List<UserVehicle> _searchableList = [];
  UserProvider _userProvider;
  UserVehicle _selectedUserVehicle;
  bool _firstTime = true;
  UserVehiclesProvider _userVehiclesProvider;
  Subtitle _subtitle;

  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _userVehiclesProvider = Provider.of<UserVehiclesProvider>(context);
    _subtitle = WinchLocalization.of(context).subtitle;
    if(_firstTime && _userVehiclesProvider.userVehicles != null){
      _searchableList.clear();
      _searchableList.addAll(_userVehiclesProvider.userVehicles);
      _firstTime = false;
    }
    return Scaffold(
      body: LoadingManager(
        isLoading: _userVehiclesProvider.isLoading,
        isFailedLoading: _userVehiclesProvider.userVehicles == null,
        stateCode: _userVehiclesProvider.stateCode,
        onRefresh: () async {
          _userVehiclesProvider.reset();
          await _userVehiclesProvider.getUserVehicles(
            userId: _userProvider.userDate.id,
            token: _userProvider.userDate.token
          );
          _searchableList.clear();
          _searchableList.addAll(_userVehiclesProvider.userVehicles);
          setState(() {});
        },
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                child: ATextFormField3(
                  hintText: "Search",
                  style: Theme.of(context).textTheme.subtitle1,
                  suffixIcon: Icons.search_rounded,
                  onChange: (value){
                    _searchableList.clear();
                    _searchableList.addAll(_userVehiclesProvider.userVehicles.where(
                            (element) => (element.category.name+element.year).toLowerCase().contains(
                            value.toLowerCase()
                        )
                    ).toList());
                    setState(() {});
                  },
                ),
              ),
              Expanded(
                child: UserVehiclesList(
                  userVehicle: _searchableList,
                  selectedUserVehicle: _selectedUserVehicle,
                  onPressed: (vehicle){
                    print(vehicle.id);
                   _selectedUserVehicle = vehicle;
                   setState(() {});
                  },
                ),
              ),
              AnimatedSize(
                duration: Duration(milliseconds: 400),
                vsync: this,
                curve: Curves.easeInOut,
                child: Visibility(
                  visible: _selectedUserVehicle?.id != null,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width /1.3,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: AButton(
                        text: "${_subtitle.pick} ${_selectedUserVehicle?.category?.name} ${_selectedUserVehicle?.year}",
                        onPressed: (){
                          Navigator.of(context).pop(_selectedUserVehicle);
                        },
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
