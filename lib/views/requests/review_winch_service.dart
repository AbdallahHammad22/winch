import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/packages_provider.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/controllers/providers/api/winch_requests_provider.dart';
import 'package:winch/controllers/validator/validator.dart';
import 'package:winch/models/coupon.dart';
import 'package:winch/models/package.dart';
import 'package:winch/models/review.dart';
import 'package:winch/models/subscription.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/user.dart';
import 'package:winch/models/user_vehicle.dart';
import 'package:winch/views/subscription/payment_method.dart';
import 'package:winch/widgets/app_text_field/app_text_form_field_3.dart';
import 'package:winch/widgets/buttons/app_back_button.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/from_top_cover.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';
import 'package:winch/widgets/packages/package_item.dart';
import 'package:winch/widgets/packages/package_picker.dart';
import 'package:winch/widgets/service_reviews/app_rate_bar.dart';
import 'package:winch/widgets/titles/app_sub_title.dart';
import 'package:winch/widgets/titles/app_title.dart';
import 'package:winch/widgets/user_vehicles/user_vechicls_picker.dart';
import 'package:winch/widgets/user_vehicles/user_vehicles_item.dart';
class ReviewWinchService extends StatefulWidget {
  static final String id = "review-winch-service";
  final WinchServiceReview review;

  const ReviewWinchService({Key key,@required this.review}) : super(key: key);
  @override
  _ReviewWinchServiceState createState() => _ReviewWinchServiceState();
}

class _ReviewWinchServiceState extends State<ReviewWinchService>
    with TickerProviderStateMixin {
  Subtitle _subtitle;
  String _language;
  bool _isLoading = false;
  WinchServiceReview _review;
  UserProvider _userProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _review = WinchServiceReview();
    _review.fromReview(widget.review);
  }
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
                    FormTopCover(_subtitle.reviewWynchService),
                    SizedBox(height: 32,),
                    Padding(
                      padding: const EdgeInsets.all(48.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ASubTitle(_subtitle.rate),
                          Center(
                            child: ARateBar(
                              starsNumber: _review.rate ?? 0,
                              tapOnlyMode: false,
                              itemSize: 32 * AStyling.getScaleFactor(context),
                              onRatingUpdate: (rate){
                                _review.rate = rate;
                                setState(() {});
                              },
                            ),
                          ),
                          ASubTitle(_subtitle.comment),
                          ATextFormField3(
                            initialValue: _review.comment,
                            textInputType: TextInputType.multiline,
                            onSaved: (value){
                              _review.comment = value;
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
                            text: _subtitle.submit,
                            onPressed: () async {
                              _formKey.currentState.save();
                              if(_review.rate == 0){
                                Fluttertoast.showToast(
                                    msg: _subtitle.requiredRate,
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    fontSize: 16.0
                                );
                                return;
                              }
                              try{
                                _isLoading = true;
                                setState(() {});
                                _review = await WinchRequestsProvider().reviewWinchService(
                                  token: _userProvider.userDate.token,
                                  language: _language,
                                  subtitle: _subtitle,
                                  winchServiceReview: _review
                                );
                                Fluttertoast.showToast(
                                    msg: _subtitle.serviceReviewSuccessfully,
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    textColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    fontSize: 16.0
                                );
                                Navigator.of(context).pop(_review);
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
