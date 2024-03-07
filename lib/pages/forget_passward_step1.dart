import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/http_status_manger/http_status_manger.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/controllers/validator/validator.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/pages/forget_password_step2.dart';
import 'package:winch/widgets/app_text_field/app_text_form_field_1.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';
import 'package:winch/widgets/titles/app_sub_title.dart';
import 'package:winch/widgets/titles/app_title.dart';
class ForgetPasswordStep1 extends StatefulWidget {
  static final String id = "/forget-password-step-1";
  @override
  _ForgetPasswordStep1State createState() => _ForgetPasswordStep1State();
}

class _ForgetPasswordStep1State extends State<ForgetPasswordStep1> {
  String _phoneNumber;

  UserProvider _userProvider;

  double _height;
  double _width;
  bool _loading = false;
  String _language;
  Subtitle _subtitle;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context){
    _userProvider = Provider.of<UserProvider>(context);
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _language = WinchLocalization.of(context).locale.languageCode;
    _subtitle = WinchLocalization.of(context).subtitle;
    return Scaffold(
      key: _scaffoldKey,
      body: LoadingManager(
        isLoading: _loading,
        stateCode: 200,
        isFailedLoading: false,
        onRefresh: (){},
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButton(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ATitle("${_subtitle.forgetPasswordStep} 1",center: true,),
                        SizedBox(height: 16,),
                        ASubTitle(_subtitle.phoneNumber),
                        SizedBox(height: 4,),
                        ATextFormField1(
                          initialValue: _phoneNumber,
                          suffixIcon: Icons.phone_android,
                          validator: (value) =>
                          Validator.isPhoneNumber(value)
                              ? null : _subtitle.phoneNumberValidateMessage,
                          textInputType: TextInputType.phone,
                          onSaved: (value){
                            _phoneNumber = value;
                          },
                        ),
                        Spacer(),
                        Center(
                          child: SizedBox(
                            width: _width/1.5,
                            child: AButton(
                              text: _subtitle.sendSms,
                              onPressed: () async {
                                if(!_formKey.currentState.validate())
                                  return;
                                _formKey.currentState.save();
                                _loading = true;
                                setState(() {});
                                int status = await _userProvider.sendCode(_phoneNumber);
                                _loading = false;
                                setState(() {});
                                if(status >= 200 && status < 300){
                                  print(status);
                                  Navigator.of(context).pushNamed(ForgetPasswordStep2.id,arguments: _phoneNumber);
                                }else{
                                  _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            HttpStatusManger.getStatusMessage(
                                                status: status, subtitle: _subtitle
                                            )
                                        ),
                                      )
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 16,),
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
