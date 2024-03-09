import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/packages_provider.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/models/enums/payment_methods_types.dart';
import 'package:winch/models/subscription.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/winch_request.dart';
import 'package:winch/views/subscription/pay_page.dart';
import 'package:winch/views/user/privacy_policy.dart';
import 'package:winch/widgets/buttons/app_back_button.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/buttons/app_flat_button.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';
import 'package:winch/widgets/payment_methods/payment_method_item.dart';
class PaymentMethod extends StatefulWidget {

  final Subscription subscription;
  final WinchRequest winchRequest;

  const PaymentMethod({Key key, this.subscription, this.winchRequest}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod>
    with TickerProviderStateMixin {

  Subtitle _subtitle;
  String _language;
  bool _isLoading = false;
  UserProvider _userProvider;
  bool _acceptPolicy = false;

  @override
  Widget build(BuildContext context) {
    _subtitle = WinchLocalization.of(context).subtitle;
    _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        backgroundColor: Theme.of(context).accentColor,
        title:  Image(
          image: AssetImage("assets/images/logo_horizontal.png"),
        ),
      ),
      body: LoadingManager(
        isLoading: _isLoading,
        stateCode: 200,
        isFailedLoading: false,
        onRefresh: (){},
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 48,vertical: 32),
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              _subtitle.paymentMethods,
                              style: Theme.of(context).textTheme.subtitle1.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textScaleFactor: AStyling.getScaleFactor(context),
                            ),
                            SizedBox(
                              width: 160 * AStyling.getScaleFactor(context),
                              child: Divider(
                                color: Theme.of(context).accentColor,
                                thickness: 3,
                              ),
                            ),
                            SizedBox(height: 32,),
                          ],
                        ),
                      ),
                      PaymentMethodItem(
                        paymentMethod: PaymentMethods.card,
                        selectedPaymentMethod:  widget.subscription == null
                            ? widget.winchRequest.paymentMethod
                            : widget.subscription.paymentMethod,
                        onPressed: (paymentMethod){
                          if(widget.subscription == null)
                            widget.winchRequest.paymentMethod =paymentMethod;
                          else
                            widget.subscription.paymentMethod = paymentMethod;
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 32,),
                      PaymentMethodItem(
                        paymentMethod: PaymentMethods.viza,
                        selectedPaymentMethod: widget.subscription == null
                            ? widget.winchRequest.paymentMethod
                            : widget.subscription.paymentMethod,
                        onPressed: (paymentMethod){
                          if(widget.subscription == null)
                            widget.winchRequest.paymentMethod =paymentMethod;
                          else
                            widget.subscription.paymentMethod = paymentMethod;
                          setState(() {});
                        },
                      ),

                    ],
                  ),
                ),
                AnimatedSize(
                  duration: Duration(milliseconds: 400),
                  vsync: this,
                  curve: Curves.easeInOut,
                  child: Visibility(
                    visible: widget.subscription == null
                        ? widget.winchRequest.paymentMethod != null
                        : widget.subscription.paymentMethod != null,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              value: _acceptPolicy,
                              title: AFlatButton(
                                text: _subtitle.acceptPrivacyPolicy,
                                onPressed: (){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_)=> Scaffold(body: PrivacyPolicy())
                                      )
                                  );
                                },
                              ),
                              onChanged: (value){
                                _acceptPolicy = value;
                                setState(() {});
                              }
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width /1.3,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: AButton(
                              text: _subtitle.next,
                              onPressed: () async {
                                try{
                                  _isLoading = true;
                                  setState(() {});
                                  if(widget.subscription == null){
                                    widget.winchRequest.referralCode = _userProvider.userDate.referralCode;
                                  } else {
                                    widget.subscription.referralCode = _userProvider.userDate.referralCode;
                                  }
                                  String url = await PackagesProvider().getPaymentUrl(
                                      token: _userProvider.userDate.token,
                                      language: _language,
                                      subtitle: _subtitle,
                                      subscription: widget.subscription,
                                      winchRequest: widget.winchRequest
                                  );
                                  Fluttertoast.showToast(
                                      msg: _subtitle.pleaseWaitUntilRedirectToPaymentGateway,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      textColor: Colors.white,
                                      backgroundColor: Colors.black,
                                      fontSize: 16.0
                                  );
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_)=> PayPage(
                                            url: url,
                                            popTo: widget.subscription?.popTo,
                                          )
                                      )
                                  );
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
                      ],
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ABackButton(),
            ),
          ],
        ),
      ),
    );
  }
}
