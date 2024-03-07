import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';

class ATextFormField3 extends StatelessWidget {
  final Function(String) onSaved;
  final Function(String) onChange;
  final Function(String) validator;
  final bool obscureText;
  final VoidCallback showPassword;
  final String hintText;
  final TextInputType textInputType;
  final String initialValue;
  final String error;
  final IconData suffixIcon;
  const ATextFormField3({
    Key key,
    this.onSaved,
    this.onChange,
    this.validator,
    this.obscureText,
    this.showPassword,
    this.hintText,
    this.textInputType = TextInputType.text,
    this.initialValue,
    this.suffixIcon,
    this.error, style
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44*AStyling.getScaleFactor(context),
      margin: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4
      ),
      decoration: BoxDecoration(
        color: AColors.lightGrey,
        boxShadow: [
          BoxShadow(
              color: AColors.grey,
              blurRadius: 10,
              offset: Offset(0,5)
          )
        ]
      ),
      child: TextFormField(
        onSaved: onSaved,
        onChanged: onChange,
        initialValue: initialValue,
        validator: validator,
        obscureText: obscureText ?? false,
        keyboardType: textInputType,
        decoration: InputDecoration(
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          suffixIcon: suffixIcon != null ?
          Icon(
            suffixIcon,
            key: ValueKey(obscureText),
          ):
          obscureText == null ? null :
          IconButton(
            icon: AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: Icon(
                  obscureText
                      ? Icons.visibility
                      : Icons.visibility_off,
                key: ValueKey(obscureText),
              ),
            ),
            onPressed:showPassword,
          ),
          hintText: hintText,
          errorText: error,
        ),
      ),
    );
  }
}
