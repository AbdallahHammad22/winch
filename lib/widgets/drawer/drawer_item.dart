import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/icons/winch_icons_icons.dart';
class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;

  const DrawerItem({Key key, this.title, this.icon, this.isSelected, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).accentColor
            : Colors.transparent
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 48,
                child: Icon(
                  icon,
                  size: icon == WinchIcons.car_of_hatchback_model ? 14 : 24,
                ),
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 16
              ),
              textScaleFactor: AStyling.getScaleFactor(context),
            ),
          ],
        ),
      ),
    );
  }
}
