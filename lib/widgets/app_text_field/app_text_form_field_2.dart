import 'package:flutter/material.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';

class ATextFormField2 extends StatelessWidget {
  final Function(String) onSaved;
  final Function(String) onChange;
  final Function(String) validator;
  final bool obscureText;
  final VoidCallback showPassword;
  final String labelText;
  final TextInputType textInputType;
  final String initialValue;
  final TextStyle style;
  final String error;
  final IconData suffixIcon;
  const ATextFormField2({
    Key key,
    this.onSaved,
    this.onChange,
    this.validator,
    this.obscureText,
    this.style,
    this.showPassword,
    this.labelText,
    this.textInputType = TextInputType.text,
    this.initialValue,
    this.suffixIcon,
    this.error
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: textInputType == TextInputType.multiline
              ? MediaQuery.of(context).size.height /6
              : null,
          margin: EdgeInsets.only(top: 14),
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: AColors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AColors.deepGrey,
            ),
            boxShadow: [
              BoxShadow(
                  color: AColors.grey,
                  blurRadius: 5,
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
            maxLines: textInputType == TextInputType.multiline ? null : 1,
            textInputAction: textInputType == TextInputType.multiline ? null : TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            style: style,
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
              errorText: error,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          padding: EdgeInsets.symmetric(horizontal: 4),
          color: AColors.white,
          child: Text(
            labelText,
            style: Theme.of(context).textTheme.subtitle1,
            textScaleFactor: AStyling.getScaleFactor(context),
          ),
        ),
      ],
    );
  }
}
