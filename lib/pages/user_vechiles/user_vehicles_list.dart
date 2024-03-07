import 'package:flutter/material.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/user_vehicle.dart';
import 'package:winch/pages/vehicles/add_vehicle.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/loaders/no_item_found.dart';
import 'package:winch/widgets/user_vehicles/user_vehicles_item.dart';

class UserVehiclesList extends StatelessWidget {

  final List<UserVehicle> userVehicle;
  final UserVehicle selectedUserVehicle;
  final Function(UserVehicle) onPressed;
  final Function(UserVehicle) onEdit;

  const UserVehiclesList({
    Key key,
    this.userVehicle,
    this.selectedUserVehicle,
    this.onPressed,
    this.onEdit
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    if(userVehicle.length == 0)
      return NoItemFound(
        message: _subtitle.noCarFound,
        actionButton: AButton(
          text: _subtitle.addACar,
          onPressed: (){
            Navigator.of(context).pushNamed(AddVehicle.id);
          },
        ),
      );

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: .8,
      crossAxisSpacing: 32,
      mainAxisSpacing: 32,
      padding: EdgeInsets.symmetric(horizontal: 48,vertical: 32),
      children: List.generate(
          userVehicle.length,
          (index) => UserVehiclesItem(
            userVehicle: userVehicle[index],
            selectedUserVehicle: selectedUserVehicle,
            onPressed: onPressed,
            onEdit: onEdit,
          )
      ),
    );
  }
}
