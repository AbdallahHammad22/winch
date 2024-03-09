import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/controllers/validator/validator.dart';
import 'package:winch/models/enums/user_gender.dart';
import 'package:winch/models/user.dart';
import 'package:winch/widgets/app_text_field/app_text_form_field_1.dart';
import 'package:winch/widgets/buttons/app_back_button.dart';
import 'package:winch/widgets/loaders/image_loader.dart';
import 'package:winch/widgets/titles/app_sub_title.dart';

class Profile extends StatefulWidget {
  static final String id = "profile";
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserProvider _userProvider;
  Size size;
  File _image;
  User _user = User();
  bool _obscurePassword = true;
  bool _firstTime = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    size = MediaQuery.of(context).size;
    if(_firstTime){
      _user = _userProvider.userDate;
    }
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              ListView(
                padding: EdgeInsets.symmetric(horizontal: 32),
                children: [
                  SizedBox(height: 16,),
                  Container(
                    width: size.width / 1.7,
                    height: size.width / 1.7,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/profile.png")
                      )
                    ),
                  ),
                  SizedBox(height: 8,),
                  ASubTitle("Name"),
                  SizedBox(height: 4,),
                  ATextFormField1(
                    initialValue: _user.name,
                    validator: (value) =>
                    Validator.hasValue(value)
                        ? null : "Name is required",
                    textInputType: TextInputType.text,
                    onSaved: (value){
                      _user.name = value;
                    },
                  ),
                  SizedBox(height: 8,),
                  ASubTitle("Phone Number"),
                  SizedBox(height: 4,),
                  ATextFormField1(
                    initialValue: _user.phoneNumber,
                    suffixIcon: Icons.phone_android,
                    error: _userProvider.error?.phone,
                    validator: (value) =>
                    Validator.isPhoneNumber(value)
                        ? null : "Not valid phone number",
                    textInputType: TextInputType.phone,
                    onSaved: (value){
                      _user.phoneNumber = value;
                    },
                  ),
                  SizedBox(height: 8,),
                  ASubTitle("E-mail"),
                  SizedBox(height: 4,),
                  ATextFormField1(
                    initialValue: _user.email,
                    suffixIcon: Icons.mail,
                    error: _userProvider.error?.email,
                    validator: (value) =>
                    Validator.isEmail(value)
                        ? null : "Not valid e-mail",
                    textInputType: TextInputType.emailAddress,
                    onSaved: (value){
                      _user.email = value;
                    },
                  ),
                  SizedBox(height: 8,),
                  ASubTitle("Password"),
                  SizedBox(height: 4,),
                  ATextFormField1(
                    initialValue: _user.password,
                    obscureText: _obscurePassword,
                    validator: (value) => Validator.isValidPassword(value)
                        ? null : "at least 6 characters or numbers",
                    showPassword: (){
                      _obscurePassword = !_obscurePassword;
                      setState(() {});
                    },
                    onSaved: (value){
                      _user.password = value;
                    },
                    onChange: (value){
                      _user.password = value;
                    },
                  ),
                  SizedBox(height: 8,),
                  ASubTitle("Confirm Password"),
                  SizedBox(height: 4,),
                  ATextFormField1(
                    initialValue: _user.password,
                    obscureText: _obscurePassword,
                    validator: (value) =>
                    _user.password == value
                        ? null : "Password and confirm password not match",
                    showPassword: (){
                      _obscurePassword = !_obscurePassword;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 8 * AStyling.getScaleFactor(context),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Radio(
                        value: Gender.male,
                        groupValue: _user.gender,
                        onChanged: (Gender value) {
                          setState(() {
                            _user.gender = value;
                          });
                        },
                      ),
                      Text('Male'),
                      Radio(
                        value: Gender.female,
                        groupValue: _user.gender,
                        onChanged: (Gender value) {
                          setState(() {
                            _user.gender = value;
                          });
                        },
                      ),
                      Text('Female'),
                    ],
                  ),
                  SizedBox(height: 8 * AStyling.getScaleFactor(context),),
                ],
              ),
              Align(alignment: Alignment.topLeft,child: ABackButton()),
            ],
          ),
        ),
      ),
    );
  }
}
