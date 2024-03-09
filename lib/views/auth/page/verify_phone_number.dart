import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/http_status_manger/http_status_manger.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/controllers/providers/settings/setting_provider.dart';
import 'package:winch/controllers/validator/validator.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/views/user/land_page.dart';
import 'package:winch/widgets/app_text_field/app_text_form_field_1.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';
import 'package:winch/widgets/titles/app_sub_title.dart';
import 'package:winch/widgets/titles/app_title.dart';

import 'login.dart';
class VerifyPhoneNumber extends StatefulWidget {
  static final String id = "/verify-phone-number";
  @override
  _VerifyPhoneNumberState createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  String _code;
  SettingProvider _settingProvider;
  UserProvider _userProvider;
  bool _loading = false;
  double _height;
  double _width;
  bool _obscurePassword = true;
  String _language;
  Subtitle _subtitle;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context){
    _settingProvider = Provider.of<SettingProvider>(context);
    _userProvider = Provider.of<UserProvider>(context);
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _language = WinchLocalization.of(context).locale.languageCode;
    _subtitle = WinchLocalization.of(context).subtitle;
    return Scaffold(
      key: _scaffoldKey,
      body: LoadingManager(
        isLoading: _loading,
        isFailedLoading: false,
        stateCode: 200,
        onRefresh: (){},
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(height:32,),
                  ATitle(_subtitle.verifyPhoneNumber,center: true,),
                  SizedBox(height: _height/24,),
                  Row(
                    children: [
                      ASubTitle("${_subtitle.code} :"),
                    ],
                  ),
                  ATextFormField1(
                    initialValue: _code,
                    validator: (value) =>
                    Validator.isNumeric(value)
                        ? null : _subtitle.notValidCode,
                    textInputType: TextInputType.phone,
                    onSaved: (value){
                      _code = value;
                    },
                  ),
                  SizedBox(height: 8,),
                  SizedBox(
                    width: _width/1.4,
                    child: AButton(
                      text: "Verify",
                      onPressed: () async {
                        if(!_formKey.currentState.validate())
                          return;
                        _formKey.currentState.save();
                        _loading = true;
                        setState(() {});
                        int status = await _userProvider.verifyPhone(code: _code);
                        _loading = false;
                        setState(() {});
                        if(status >= 200 && status < 300){
                          Fluttertoast.showToast(
                              msg: _subtitle.accountActivateSuccessfully,
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 2,
                              backgroundColor: AColors.black,
                              fontSize: 16.0
                          );
                          _settingProvider.setUser(_userProvider.userDate);
                          Navigator.of(context).pushNamed(LandPage.id,arguments: true);
                        }else{
                          String errorMessage = status == 400
                              ? _subtitle.invalidCode
                              : HttpStatusManger.getStatusMessage(
                              status: status, subtitle: _subtitle);
                          _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text(
                                    errorMessage ?? ""
                                ),
                              )
                          );
                        }
                      },
                    ),
                  ),
                  Spacer(),
                  AButton(
                    text: _subtitle.resendSms,
                    onPressed: () async {
                      _loading = true;
                      setState(() {});
                      int statue = await _userProvider.sendCode(_userProvider.userDate.phoneNumber);
                      _loading = false;
                      setState(() {});
                      if(statue >= 200 && statue < 300){
                        _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text(
                                _subtitle.smsResendSuccessfully
                              ),
                            )
                        );
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
                  SizedBox(height: 32,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
