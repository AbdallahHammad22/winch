import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/user_vehicle.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/titles/app_title.dart';

class UserVehiclesItem extends StatelessWidget {
  final UserVehicle userVehicle;
  final UserVehicle selectedUserVehicle;
  final Function(UserVehicle) onPressed;
  final Function(UserVehicle) onEdit;

  const UserVehiclesItem({
    Key key, this.userVehicle, this.selectedUserVehicle,this.onPressed,this.onEdit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Subtitle _subtitle = WinchLocalization.of(context).subtitle;
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: AColors.white,
        border: Border.all(
          color: selectedUserVehicle == userVehicle
              ? Colors.transparent : AColors.black,
          width: 2
        ),
        boxShadow: [
          selectedUserVehicle == userVehicle
              ? AStyling.boxShadow : BoxShadow()
        ]
      ),
      child: MaterialButton(
        onPressed: (){
          onPressed(userVehicle);
        },
        child: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image(
                  image: AssetImage("assets/images/car_image.png"),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  userVehicle == null ? _subtitle.pickCar :
                  ((userVehicle?.category?.name?? '') + " "+ (userVehicle?.year ?? "")),
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                    fontSize: 14
                  ),
                  textAlign: TextAlign.center,
                  textScaleFactor: AStyling.getScaleFactor(context),
                ),
              ),
            ),
            onEdit == null ? SizedBox.shrink() :
            Expanded(
              child: Center(
                child: SizedBox(
                  height: 30,
                  child: AButton(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    text: _subtitle.edit,
                    onPressed: (){
                      onEdit(userVehicle);
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 8,),
          ],
        ),

      ),
    );
  }
}
