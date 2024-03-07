import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/http_status_manger/http_status_manger.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/about_provider.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/controllers/providers/widgets/land_page_provider.dart';
import 'package:winch/controllers/validator/validator.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/widgets/app_text_field/app_text_form_field_2.dart';
import 'package:winch/widgets/buttons/app_back_button.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/buttons/app_icon_button_1.dart';
import 'package:winch/widgets/buttons/app_icon_button_2.dart';
import 'package:winch/widgets/buttons/app_text_button_with_icon.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';
import 'package:winch/widgets/titles/app_title.dart';
class ContactUs extends StatefulWidget {
  static final String id = "contact-us";
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  LandPageProvider _landPageProvider;
  UserProvider _userProvider;
  AboutProvider _aboutProvider;
  String _language;
  String _phone;
  String _email;
  String _message;
  bool _isLoading = false;
  Subtitle _subtitle;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void launchUrl(String url,String message){
    if(url == null || url.isEmpty){
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          textColor: Colors.white,
          backgroundColor: Colors.black,
          fontSize: 16.0
      );
      return;
    }
    if(Validator.isPhoneNumber(url))
      launch("tel:$url");
    launch(url);
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    _landPageProvider = Provider.of<LandPageProvider>(context);
    _aboutProvider = Provider.of<AboutProvider>(context);
    _userProvider = Provider.of<UserProvider>(context);
    _language = WinchLocalization.of(context).locale.languageCode;
    _subtitle = WinchLocalization.of(context).subtitle;
    return LoadingManager(
      isLoading: _aboutProvider.isLoading || _isLoading,
      isFailedLoading: _aboutProvider.aboutData == null,
      stateCode: _aboutProvider.stateCode,
      onRefresh: () async {
        _aboutProvider.reset();
        await _aboutProvider.getAboutData(
            token: _userProvider.userDate.token,
            language: _language
        );
      },
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12,),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Expanded(
                  child: Image(
                    width: _width,
                    image: AssetImage("assets/images/contact_us.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(width: 12,),
                SizedBox(
                  width: _width/1.5,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 16,),
                          Expanded(
                            child: ABackButton(
                              onPressed: (){
                                _landPageProvider.reset();
                              },
                            ),
                          ),
                          ATitle(_subtitle.contactUs),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Divider(
                                color: Theme.of(context).accentColor,
                                thickness: 3,
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          SizedBox(height: 12,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ATextButtonWithIcon(
                  text: _aboutProvider.aboutData?.email,
                  iconData: FontAwesomeIcons.mailBulk,
                  onPressed: (){
                    launchUrl(
                      _aboutProvider.aboutData.facebook,
                      _subtitle.facebookNotAvailable,
                    );
                  },
                ),
                SizedBox(height: 8,),
                ATextButtonWithIcon(
                  text: _aboutProvider.aboutData?.facebook,
                  iconData: FontAwesomeIcons.facebookF,
                  onPressed: (){
                    launchUrl(
                      _aboutProvider.aboutData.facebook,
                      _subtitle.facebookNotAvailable,
                    );
                  },
                ),
                SizedBox(height: 8,),
                ATextButtonWithIcon(
                  iconData: FontAwesomeIcons.instagram,
                  text: _aboutProvider.aboutData?.instagram,
                  onPressed: (){
                    launchUrl(
                      _aboutProvider.aboutData?.instagram,
                      _subtitle.instagramNotAvailable,
                    );
                  },
                ),
                SizedBox(height: 8,),
                ATextButtonWithIcon(
                  iconData: FontAwesomeIcons.phoneAlt,
                  text: _aboutProvider.aboutData?.phone1,
                  onPressed: (){
                    launchUrl(
                      _aboutProvider.aboutData?.phone1,
                      _subtitle.phoneNumberNotAvailable,
                    );
                  },
                ),
                SizedBox(height: 8,),
                ATextButtonWithIcon(
                  iconData: FontAwesomeIcons.phoneAlt,
                  text: _aboutProvider.aboutData?.phone2,
                  onPressed: (){
                    launchUrl(
                      _aboutProvider.aboutData?.phone2,
                      _subtitle.phoneNumberNotAvailable,
                    );
                  },
                ),

              ],
            ),
          ),

          SizedBox(height:16,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ATextFormField2(
                    initialValue:  _phone ?? _userProvider.userDate.phoneNumber,
                    labelText: _subtitle.phoneNumber,
                    validator: (value) =>
                    Validator.isPhoneNumber(value)
                        ? null : _subtitle.phoneNumberValidateMessage,
                    textInputType: TextInputType.phone,
                    onSaved: (value){
                      _phone = value;
                    },
                  ),
                  SizedBox(height: 16,),
                  ATextFormField2(
                    initialValue: _email ?? _userProvider.userDate.email,
                    labelText: _subtitle.email,
                    validator: (value) =>
                    Validator.isEmail(value)
                        ? null : _subtitle.emailValidateMessage,
                    textInputType: TextInputType.emailAddress,
                    onSaved: (value){
                      _email = value;
                    },
                  ),
                  SizedBox(height: 16,),
                  ATextFormField2(
                    initialValue: _message,
                    labelText: _subtitle.message,
                    validator: (value) =>
                    Validator.hasValue(value)
                        ? null : _subtitle.messageValidateMessage,
                    textInputType: TextInputType.multiline,
                    onSaved: (value){
                      _message = value;
                    },
                  ),
                  SizedBox(height: 16,),
                ],
              ),
            ),
          ),
          SizedBox(height:16,),
          Center(
            child: SizedBox(
              width: _width/1.5,
              child: AButton(
                text: _subtitle.send,
                color: Theme.of(context).accentColor,
                onPressed: () async {
                  if(!_formKey.currentState.validate())
                    return false;
                  _formKey.currentState.save();
                  _isLoading = true;
                  setState(() {});
                  int statue = await _aboutProvider.contactUs(
                    token: _userProvider.userDate.token,
                    name: _userProvider.userDate.name,
                    email: _email,
                    phone: _phone,
                    message: _message
                  );
                  _isLoading = false;
                  setState(() {});
                  if(statue >= 200 && statue < 300){
                    _message = null;
                    _phone = null;
                    _email = null;
                    setState(() {});
                    Fluttertoast.showToast(
                        msg: _subtitle.messageDeliveredSuccessfully,
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        textColor: Colors.white,
                        backgroundColor: Colors.black,
                        fontSize: 16.0
                    );
                  }else{
                    Fluttertoast.showToast(
                        msg: HttpStatusManger.getStatusMessage(
                            status: statue, subtitle: _subtitle
                        ),
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        textColor: Colors.white,
                        backgroundColor: Colors.black,
                        fontSize: 16.0
                    );
                  }
                },
              ),
            ),
          ),
          SizedBox(height: _height / 28,),
        ],
      ),
    );
  }
}
