import 'package:flutter/material.dart';
class ABackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ABackButton({Key key, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).accentColor,
            )
          ),
          child: Icon(
            Icons.arrow_back_rounded,
          ),
        ),
        iconSize: 32,
        onPressed:onPressed ?? (){
          Navigator.of(context).pop();
        }
    );
  }
}
