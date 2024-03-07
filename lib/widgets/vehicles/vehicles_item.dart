import 'package:flutter/material.dart';
import 'package:winch/models/vehicle.dart';

class VehicleItem extends StatelessWidget {
  final Vehicle vehicle;
  final VoidCallback onPressed;

  const VehicleItem({Key key, this.vehicle, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
          vehicle.name ?? "--- no name found ---",
        style: Theme.of(context).textTheme.subtitle1,
      ),
      onTap: onPressed,
    );
  }
}
