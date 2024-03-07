import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'package:winch/models/enums/user_types.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/user.dart';
import 'package:winch/pages/forget_password_step2.dart';
import 'package:winch/pages/register.dart';
import 'package:winch/pages/user/land_page.dart';
import 'package:winch/pages/verify_phone_number.dart';
import 'package:winch/widgets/app_text_field/app_text_form_field_1.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/buttons/app_flat_button.dart';
import 'package:winch/widgets/buttons/app_icon_button_1.dart';
import 'package:winch/widgets/buttons/app_out_line_button.dart';
import 'package:winch/widgets/dialogs/dialog.dart';
import 'package:winch/widgets/from_top_cover.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';

import 'package:winch/widgets/titles/app_sub_title.dart';

import 'forget_passward_step1.dart';
class Login extends StatefulWidget {
  static final String id = "/login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
  User _user = User();
  bool _obscurePassword = true;
  String _language;
  Subtitle _subtitle;
  bool _firstTime = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _settingProvider = Provider.of<SettingProvider>(context);
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
    if(_firstTime && !_settingProvider.isLoading){
      _user = _settingProvider.user;

      WidgetsBinding.instance
          .addPostFrameCallback((_) {
        _userProvider.userDate = _user;
        print(_user.toJson());
        if(_user.token != null && _user.token.isNotEmpty){
          Navigator.of(context).pushNamed(LandPage.id);
        }
      });
      _firstTime = false;
    }
    return WillPopScope(
      onWillPop: ()async{
        bool result = await showDialog(
            context: context,
            builder: (_) => AAlertDialog(
              title: _subtitle.exit,
              content: _subtitle.exitAlert,
            )
        );
        if(result == true){
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: LoadingManager(
          isLoading: _userProvider.isLoading || _settingProvider.isLoading,
          isFailedLoading: false,
          stateCode: 200,
          onRefresh: (){},
          child: SafeArea(
            child: Stack(
              children: [
                Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      FormTopCover(_subtitle.signInWithEmailOrPhoneAndPassword),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 16 * AStyling.getScaleFactor(context),
                            horizontal: 16 * AStyling.getScaleFactor(context),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //SizedBox(height: 16,),
                            ASubTitle(_subtitle.emailOrPhoneNumber),
                            SizedBox(height: 4,),
                            ATextFormField1(
                              initialValue: _user.email ?? _user.phoneNumber,
                              //hintText: "email or phone",
                              validator: (value) =>
                              Validator.isEmail(value)
                                  || Validator.isPhoneNumber(value)
                                  ? null : _subtitle.notValidPhoneNumberOrEmail,
                              textInputType: TextInputType.emailAddress,
                              onSaved: (value){
                                if(Validator.isEmail(value)){
                                  _user.email = value;
                                  _user.phoneNumber = null;
                                }
                                else{
                                  _user.phoneNumber = value;
                                  _user.email = null;
                                }

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
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AFlatButton(
                                  text: _subtitle.forgetPassword,
                                  onPressed: (){
                                    Navigator.of(context).pushNamed(ForgetPasswordStep1.id);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 8,),
                            Center(
                              child: SizedBox(
                                width: _width/1.8,
                                child: AButton(
                                  text: _subtitle.signIn,
                                  onPressed: () async {
                                    if(!_formKey.currentState.validate())
                                      return;
                                    _formKey.currentState.save();
                                    _user.fireBaseToken = await FirebaseMessaging.instance.getToken();
                                    print(_user.fireBaseToken);
                                    int status = await _userProvider.login(
                                      user: _user,
                                      language: _language
                                    );
                                    if(status >= 200 && status < 300){
                                      if(_userProvider.userDate.phoneVerifiedAt == null){

                                        Navigator.of(context).pushNamed(VerifyPhoneNumber.id);
                                      } else{

                                        _settingProvider.setUser(_userProvider.userDate);
                                        Navigator.of(context).pushNamed(LandPage.id);
                                      }

                                    }else{
                                      String errorMessage = status == 403
                                          ? _subtitle.wrongEmailPhoneNumberOrPassword
                                          : HttpStatusManger.getStatusMessage(
                                          status: status, subtitle: _subtitle);
                                      _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                errorMessage
                                            ),
                                          )
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 16,),
                            Visibility(
                              visible: false,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  AIconButton1(
                                    iconData: FontAwesomeIcons.googlePlusG,
                                    onPressed: (){

                                    },
                                  ),
                                  AIconButton1(
                                    iconData: FontAwesomeIcons.facebookF,
                                    onPressed: (){},
                                  ),
                                  AIconButton1(
                                    iconData: FontAwesomeIcons.apple,
                                    onPressed: (){},
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 16,),
                            Center(
                              child: AOutLineButton(
                                text: _subtitle.becomeAMember,
                                onPressed: (){
                                  Navigator.of(context).pushNamed(Register.id);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
            ),
          ),
        ),
      ),
    );
  }
}
