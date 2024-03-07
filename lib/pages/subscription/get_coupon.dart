import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/packages_provider.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/controllers/validator/validator.dart';
import 'package:winch/models/coupon.dart';
import 'package:winch/models/package.dart';
import 'package:winch/models/subscription.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/user.dart';
import 'package:winch/models/user_vehicle.dart';
import 'package:winch/pages/subscription/payment_method.dart';
import 'package:winch/widgets/app_text_field/app_text_form_field_3.dart';
import 'package:winch/widgets/buttons/app_back_button.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/from_top_cover.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';
import 'package:winch/widgets/packages/package_item.dart';
import 'package:winch/widgets/packages/package_picker.dart';
import 'package:winch/widgets/titles/app_sub_title.dart';
import 'package:winch/widgets/titles/app_title.dart';
import 'package:winch/widgets/user_vehicles/user_vechicls_picker.dart';
import 'package:winch/widgets/user_vehicles/user_vehicles_item.dart';
class GetCoupon extends StatefulWidget {
  static final String id = "get-coupon";
  @override
  _GetCouponState createState() => _GetCouponState();
}

class _GetCouponState extends State<GetCoupon>
    with TickerProviderStateMixin {
  Subtitle _subtitle;
  String _language;
  bool _isLoading = false;
  Coupon _coupon = Coupon();
  UserProvider _userProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _subtitle = WinchLocalization.of(context).subtitle;
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        stateCode: 200,
        isFailedLoading: false,
        onRefresh: (){},
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Stack(
              children: [
                ListView(
                  children: [
                    FormTopCover(_subtitle.checkCoupon),
                    SizedBox(height: 32,),
                    Padding(
                      padding: const EdgeInsets.all(48.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ASubTitle(_subtitle.coupon),
                          ATextFormField3(
                            initialValue: _coupon.code,
                            validator: (value) =>
                            Validator.hasValue(value)
                                ? null : _subtitle.requiredCoupon,
                            textInputType: TextInputType.text,
                            onSaved: (value){
                              _coupon.code = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32,),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width /1.3,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: AButton(
                            text: _subtitle.check,
                            onPressed: () async {
                              if(!_formKey.currentState.validate())
                                return;
                              _formKey.currentState.save();
                              try{
                                _isLoading = true;
                                setState(() {});
                                _coupon = await PackagesProvider().getCoupon(
                                  token: _userProvider.userDate.token,
                                  language: _language,
                                  subtitle: _subtitle,
                                  coupon: _coupon
                                );
                                Fluttertoast.showToast(
                                    msg: _subtitle.validCoupon,
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    fontSize: 16.0
                                );
                                Navigator.of(context).pop(_coupon);
                              }catch(error){
                                Fluttertoast.showToast(
                                    msg: error.toString(),
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    fontSize: 16.0
                                );
                              }
                              _isLoading = false;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                ABackButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
