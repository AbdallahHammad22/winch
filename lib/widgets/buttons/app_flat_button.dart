import 'package:flutter/material.dart';
class AFlatButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AFlatButton({Key key, this.text, this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(text??""),
      onPressed: onPressed
    );
  }
}
