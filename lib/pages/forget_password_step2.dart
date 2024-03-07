import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/http_status_manger/http_status_manger.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/controllers/validator/validator.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/widgets/app_text_field/app_text_form_field_1.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';
import 'package:winch/widgets/titles/app_sub_title.dart';
import 'package:winch/widgets/titles/app_title.dart';

import 'login.dart';
class ForgetPasswordStep2 extends StatefulWidget {
  static final String id = "/forget-password-step-2";
  @override
  _ForgetPasswordStep2State createState() => _ForgetPasswordStep2State();
}

class _ForgetPasswordStep2State extends State<ForgetPasswordStep2> {
  String _code;

  UserProvider _userProvider;

  double _height;
  String _password;
  String _phone;
  bool _loading = false;
  bool _obscurePassword = true;
  String _language;
  Subtitle _subtitle;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context){
    _phone = ModalRoute.of(context).settings.arguments;
    _userProvider = Provider.of<UserProvider>(context);
    _height = MediaQuery.of(context).size.height;
    _language = WinchLocalization.of(context).locale.languageCode;
    _subtitle = WinchLocalization.of(context).subtitle;
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: LoadingManager(
          isLoading: _loading,
          stateCode: 200,
          isFailedLoading: false,
          onRefresh: (){},
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButton(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ATitle("${_subtitle.forgetPasswordStep} 2",center: true,),
                        SizedBox(height: 32,),
                        ASubTitle(_subtitle.code),
                        SizedBox(height: 4,),
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
                        ASubTitle(_subtitle.password),
                        SizedBox(height: 4,),
                        ATextFormField1(
                          initialValue: _password,
                          obscureText: _obscurePassword,
                          validator: (value) => Validator.isValidPassword(value)
                              ? null : _subtitle.passwordValidateMessage,
                          showPassword: (){
                            _obscurePassword = !_obscurePassword;
                            setState(() {});
                          },
                          onSaved: (value){
                            _password = value;
                          },
                          onChange: (value){
                            _password = value;
                          },
                        ),
                        SizedBox(height: 8,),
                        ASubTitle(_subtitle.confirmPassword),
                        SizedBox(height: 4,),
                        ATextFormField1(
                          initialValue: _password,
                          obscureText: _obscurePassword,
                          validator: (value) =>
                          _password == value
                              ? null : _subtitle.confirmPasswordValidateMessage,
                          showPassword: (){
                            _obscurePassword = !_obscurePassword;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 8,),
                        Center(
                          child: AButton(
                            text: _subtitle.resetPassword,
                            onPressed: () async {
                              if(!_formKey.currentState.validate())
                                return;
                              _formKey.currentState.save();
                              _loading = true;
                              setState(() {});
                              int status = await _userProvider.resetPassword(
                                password: _password,
                                phone: _phone,
                                code: _code
                              );
                              _loading = false;
                              setState(() {});
                              if(status >= 200 && status < 300){
                                Fluttertoast.showToast(
                                    msg: _subtitle.passwordResetSuccessfully,
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: AColors.black,
                                    fontSize: 16.0
                                );
                                Navigator.of(context).popUntil(ModalRoute.withName(Login.id));
                              }else{
                                String errorMessage = status == 400
                                    ? _subtitle.invalidCode
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
                        Spacer(),
                        Center(
                          child: AButton(
                            text: _subtitle.resendSms,
                            onPressed: () async {
                              _loading = true;
                              setState(() {});
                              int status = await _userProvider.sendCode(_userProvider.userDate.phoneNumber);
                              _loading = false;
                              setState(() {});
                              if(status >= 200 && status < 300){
                                _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          _subtitle.smsResendSuccessfully
                                      ),
                                    )
                                );
                              }else{
                                String errorMessage = HttpStatusManger.getStatusMessage(
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
                        SizedBox(height: 8,),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
