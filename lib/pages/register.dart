import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/http_status_manger/http_status_manger.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/about_provider.dart';
import 'package:winch/controllers/providers/api/categories_provider.dart';
import 'package:winch/controllers/providers/api/packages_provider.dart';
import 'package:winch/controllers/providers/api/privacy_policy_provider.dart';
import 'package:winch/controllers/providers/api/terms_and_conditions_provider.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/controllers/providers/api/user_vehicles_provider.dart';
import 'package:winch/controllers/providers/settings/setting_provider.dart';
import 'package:winch/controllers/validator/validator.dart';
import 'package:winch/models/enums/user_gender.dart';
import 'package:winch/models/enums/user_types.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/user.dart';
import 'package:winch/pages/user/terms_and_conditions.dart';
import 'package:winch/pages/verify_phone_number.dart';
import 'package:winch/widgets/app_text_field/app_text_form_field_1.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/buttons/app_flat_button.dart';
import 'package:winch/widgets/buttons/app_icon_button_1.dart';
import 'package:winch/widgets/from_top_cover.dart';

import 'package:winch/widgets/image_picker.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';
import 'package:winch/widgets/titles/app_sub_title.dart';
class Register extends StatefulWidget {
  static final String id = "/register";
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  UserProvider _userProvider;
  SettingProvider _settingProvider;
  PackagesProvider _packagesProvider;
  UserVehiclesProvider _userVehiclesProvider;
  PrivacyPolicyProvider _privacyPolicyProvider;
  TermsAndConditionsProvider _termsAndConditionsProvider;
  CategoriesProvider _categoriesProvider;
  AboutProvider _aboutProvider;
  double _height;
  double _width;
  bool _acceptTermsAndConditions = false;
  File _image;
  User _user = User();
  bool _obscurePassword = true;
  String _language;
  Subtitle _subtitle;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _settingProvider = Provider.of<SettingProvider>(context);
    _userProvider = Provider.of<UserProvider>(context);
    _userVehiclesProvider = Provider.of<UserVehiclesProvider>(context);
    _packagesProvider = Provider.of<PackagesProvider>(context);
    _privacyPolicyProvider = Provider.of<PrivacyPolicyProvider>(context);
    _termsAndConditionsProvider = Provider.of<TermsAndConditionsProvider>(context);
    _categoriesProvider = Provider.of<CategoriesProvider>(context);
    _aboutProvider = Provider.of<AboutProvider>(context);
    _language = WinchLocalization.of(context).locale.languageCode;
    _subtitle = WinchLocalization.of(context).subtitle;
    return Scaffold(
      key: _scaffoldKey,
      body: LoadingManager(
        isLoading: _userProvider.isLoading,
        isFailedLoading: false,
        stateCode: 200,
        onRefresh: (){},
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Stack(
              children: [
                ListView(
                  children: [
                    FormTopCover(_subtitle.signUpWithEmailAndPhone),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8,),
                          ASubTitle(_subtitle.name),
                          SizedBox(height: 4,),
                          ATextFormField1(
                            initialValue: _user.name,
                            validator: (value) =>
                            Validator.hasValue(value)
                                ? null : _subtitle.nameValidateMessage,
                            textInputType: TextInputType.text,
                            onSaved: (value){
                              _user.name = value;
                            },
                          ),
                          SizedBox(height: 8,),
                          ASubTitle(_subtitle.phoneNumber),
                          SizedBox(height: 4,),
                          ATextFormField1(
                            initialValue: _user.phoneNumber,
                            suffixIcon: Icons.phone_android,
                            error: _userProvider.error?.phone,
                            validator: (value) =>
                            Validator.isPhoneNumber(value)
                                ? null : _subtitle.phoneNumberValidateMessage,
                            textInputType: TextInputType.phone,
                            onSaved: (value){
                              _user.phoneNumber = value;
                            },
                          ),
                          SizedBox(height: 8,),
                          ASubTitle(_subtitle.email),
                          SizedBox(height: 4,),
                          ATextFormField1(
                            initialValue: _user.email,
                            suffixIcon: Icons.mail,
                            error: _userProvider.error?.email,
                            validator: (value) =>
                            Validator.isEmail(value)
                                ? null : _subtitle.emailValidateMessage,
                            textInputType: TextInputType.emailAddress,
                            onSaved: (value){
                              _user.email = value;
                            },
                          ),
                          SizedBox(height: 8,),
                          ASubTitle(_subtitle.password),
                          SizedBox(height: 4,),
                          ATextFormField1(
                            initialValue: _user.password,
                            obscureText: _obscurePassword,
                            validator: (value) => Validator.isValidPassword(value)
                                ? null : _subtitle.passwordValidateMessage,
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
                          ASubTitle(_subtitle.confirmPassword),
                          SizedBox(height: 4,),
                          ATextFormField1(
                            initialValue: _user.password,
                            obscureText: _obscurePassword,
                            validator: (value) =>
                            _user.password == value
                                ? null : _subtitle.confirmPasswordValidateMessage,
                            showPassword: (){
                              _obscurePassword = !_obscurePassword;
                              setState(() {});
                            },
                          ),

                          SizedBox(height: 8,),
                          ASubTitle(_subtitle.code),
                          SizedBox(height: 4,),
                          ATextFormField1(
                            initialValue: _user.referralCode,
                            textInputType: TextInputType.text,
                            onSaved: (value){
                              _user.referralCode = value;
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
                              Text(_subtitle.male),
                              Radio(
                                value: Gender.female,
                                groupValue: _user.gender,
                                onChanged: (Gender value) {
                                  setState(() {
                                    _user.gender = value;
                                  });
                                },
                              ),
                              Text(_subtitle.female),
                            ],
                          ),
                          SizedBox(height: 8 * AStyling.getScaleFactor(context),),
                          CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              value: _acceptTermsAndConditions,
                              title: FlatButton(
                                  child: Text(_subtitle.acceptTermsAndConditions),
                                onPressed: (){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_)=> TermsAndConditions()
                                      )
                                  );
                                },
                              ),
                              onChanged: (value){
                                _acceptTermsAndConditions = value;
                                setState(() {});
                              }
                          ),
                          SizedBox(height: 8 * AStyling.getScaleFactor(context),),
                          Center(
                            child: SizedBox(
                              width: _width/1.8,
                              child: AButton(
                                text: _subtitle.signUp,
                                onPressed: () async {
                                  if(!_formKey.currentState.validate())
                                    return;
                                  _formKey.currentState.save();
                                  if(!_acceptTermsAndConditions){
                                    _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            _subtitle.termsAndConditionsValidateMessage
                                        ),
                                      )
                                    );
                                    return;
                                  }
                                  int statue = await _userProvider.register(
                                      user: _user,
                                    language: _language
                                  );
                                  if(statue >= 200 && statue < 300){
                                    Navigator.of(context).pushNamed(VerifyPhoneNumber.id);
                                  }else{
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              HttpStatusManger.getStatusMessage(
                                                  status: statue, subtitle: _subtitle
                                              )
                                          ),
                                        )
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 16 * AStyling.getScaleFactor(context),),
                          Visibility(
                            visible: false,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                AIconButton1(
                                  iconData: FontAwesomeIcons.google,
                                  onPressed: (){},
                                ),
                                AIconButton1(
                                  iconData: FontAwesomeIcons.facebook,
                                  onPressed: (){},
                                ),
                                AIconButton1(
                                  iconData: FontAwesomeIcons.apple,
                                  onPressed: (){},
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 32,)
                        ],
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    BackButton(),
                    Spacer(),
                    AFlatButton(
                      text: _subtitle.language,
                      onPressed: () async {
                        if(_language == "ar")
                          await _settingProvider.setLanguage("en");
                        else
                          await _settingProvider.setLanguage("ar");

                        _aboutProvider.reset();
                        _categoriesProvider.reset();
                        _termsAndConditionsProvider.reset();
                        _privacyPolicyProvider.reset();
                        _packagesProvider.reset();
                        _userVehiclesProvider.reset();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
