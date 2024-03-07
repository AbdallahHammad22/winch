import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/http_status_manger/http_status_manger.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/controllers/providers/api/winch_requests_provider.dart';
import 'package:winch/controllers/validator/validator.dart';
import 'package:winch/models/coupon.dart';
import 'package:winch/models/enums/winch_request_types.dart';
import 'package:winch/models/package.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/user_vehicle.dart';
import 'package:winch/models/winch_request.dart';
import 'package:winch/pages/requests/request_done_page.dart';
import 'package:winch/pages/subscription/get_coupon.dart';
import 'package:winch/pages/subscription/payment_method.dart';
import 'package:winch/widgets/app_text_field/app_text_form_field_1.dart';
import 'package:winch/widgets/app_text_field/app_text_form_field_3.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/day_and_time/date_picker.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';
import 'package:winch/widgets/maps/app_map.dart';
import 'package:winch/widgets/maps/view_location.dart';
import 'package:winch/widgets/titles/app_sub_title.dart';
import 'package:winch/widgets/titles/app_title.dart';
import 'package:winch/widgets/user_vehicles/user_vechicls_picker.dart';
import 'package:winch/widgets/user_vehicles/user_vehicles_item.dart';
import 'package:winch/widgets/winch_requests/toggle_winch_request_type.dart';
class CreateWinchRequest extends StatefulWidget {
  final WinchRequest winchRequest;

  const CreateWinchRequest({Key key, this.winchRequest}) : super(key: key);
  @override
  _CreateWinchRequestState createState() => _CreateWinchRequestState();
}

class _CreateWinchRequestState extends State<CreateWinchRequest>
    with TickerProviderStateMixin {
  Size _size;
  bool _isLoading = false;
  UserProvider _userProvider;
  WinchRequestsProvider _winchRequestsProvider;
  String _language;
  Subtitle _subtitle;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    _userProvider = Provider.of<UserProvider>(context);
    _winchRequestsProvider = Provider.of<WinchRequestsProvider>(context);
    _language = WinchLocalization.of(context).locale.languageCode;
    _subtitle = WinchLocalization.of(context).subtitle;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title:  Image(
          image: AssetImage("assets/images/logo_horizontal.png"),
        ),
      ),
      body: Form(
        key: _formKey,
        child: LoadingManager(
          stateCode: 200,
          isFailedLoading: false,
          isLoading: _isLoading,
          onRefresh: (){},
          child: ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(height: 32,),
                    Text(
                      _subtitle.wynchRequest,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textScaleFactor: AStyling.getScaleFactor(context),
                    ),
                    SizedBox(
                      width: 180 * AStyling.getScaleFactor(context),
                      child: Divider(
                        color: Theme.of(context).accentColor,
                        thickness: 3,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ASubTitle(_subtitle.startLocation),
              ),
              SizedBox(
                height: _size.height/6,
                child: ViewLocation(
                  location:  widget.winchRequest.startLocation,
                )
              ),
              SizedBox(height: 8,),
              Padding(
               padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ASubTitle(_subtitle.endLocation),
              ),
              SizedBox(
                  height: _size.height/6,
                  child: ViewLocation(
                    location:  widget.winchRequest.endLocation,
                  )
              ),
              SizedBox(height: 8,),
              Padding(
               padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ASubTitle(_subtitle.pickCar),
              ),
              SizedBox(
                height: 100 * AStyling.getScaleFactor(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: UserVehiclesItem(
                    userVehicle: widget.winchRequest.userVehicle,
                    selectedUserVehicle: UserVehicle(),
                    onPressed: (vehicles) async {
                      UserVehicle _userVehicle = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_)=> UserVehiclesPicker()
                          )
                      ) as UserVehicle;
                      if(_userVehicle != null){
                        widget.winchRequest.userVehicle = _userVehicle;
                        setState(() {});
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 16,),
              Padding(
               padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ASubTitle(_subtitle.requestType),
              ),

              ToggleWinchRequestType(
                initialIndex: widget.winchRequest.winchRequestType.index ,
                onTab: (index){
                  widget.winchRequest.winchRequestType
                    = WinchRequestType.values[index];
                  widget.winchRequest.date = null;
                  setState(() {});
                },
              ),
              SizedBox(height: 8,),
              AnimatedSize(
                duration: Duration(milliseconds: 400),
                vsync: this,
                child: Visibility(
                  visible:  widget.winchRequest.winchRequestType == WinchRequestType.scheduled,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8,),
                        ASubTitle(_subtitle.requestDateAndTime),
                        SizedBox(height: 4,),
                        Row(
                          children: [
                            Expanded(
                              child: DatePicker(
                                date: widget.winchRequest.date,
                                onDatePicker: (date){
                                  widget.winchRequest.date = date;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height: 8,),
                    ASubTitle(_subtitle.phoneNumber),
                    SizedBox(height: 4,),
                    ATextFormField3(
                      initialValue: widget.winchRequest.phone,
                      suffixIcon: Icons.phone_android,
                      validator: (value) =>
                      Validator.isPhoneNumber(value) || value.isEmpty
                          ? null : _subtitle.phoneNumberValidateMessage,
                      textInputType: TextInputType.phone,
                      onSaved: (value){
                        widget.winchRequest.phone = value;
                      },
                    ),
                    SizedBox(height: 8,),
                    ASubTitle(_subtitle.notes),
                    SizedBox(height: 4,),
                    ATextFormField3(
                      initialValue: widget.winchRequest.note,
                      suffixIcon: Icons.notes,
                      textInputType: TextInputType.multiline,
                      onSaved: (value){
                        widget.winchRequest.note = value;
                      },
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: widget.winchRequest.userVehicle == null
                    || widget.winchRequest.userVehicle?.package == null
                    || widget.winchRequest.userVehicle?.package?.expiryDate?.isBefore(DateTime.now()) == true,
                child: Column(
                  children: [
                    SizedBox(height: 8,),
                    ATitle(_subtitle.coupon),
                    SizedBox(height: 4,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: AButton(
                        text: widget.winchRequest.coupon?.title ??_subtitle.addCoupon,
                        onPressed: () async {
                          widget.winchRequest.coupon = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_)=> GetCoupon()
                              )
                          ) as Coupon;
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32,),
              Center(
                child: SizedBox(
                  width: _size.width /1.5,
                  child: AButton(
                    text: _subtitle.createRequest,
                    onPressed: () async {
                      if(!_formKey.currentState.validate())
                        return;
                      _formKey.currentState.save();
                      if(widget.winchRequest.userVehicle == null){
                        Fluttertoast.showToast(
                            msg: _subtitle.requiredCarToMackRequest,
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            textColor: Colors.white,
                            backgroundColor: Colors.black,
                            fontSize: 16.0
                        );
                        return;
                      }
                      if(widget.winchRequest.winchRequestType == WinchRequestType.scheduled){
                        if(widget.winchRequest.date == null){
                          Fluttertoast.showToast(
                              msg: _subtitle.requiredDateInScheduledRequest,
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              textColor: Colors.white,
                              backgroundColor: Colors.black,
                              fontSize: 16.0
                          );
                          return;
                        }else{
                          if(widget.winchRequest.date.isBefore(DateTime.now())){
                            Fluttertoast.showToast(
                                msg: _subtitle.dateHasAlreadyPassed,
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                textColor: Colors.white,
                                backgroundColor: Colors.black,
                                fontSize: 16.0
                            );
                            return;
                          }
                        }
                      }else{
                        widget.winchRequest.winchRequestType = WinchRequestType.live;
                        widget.winchRequest.date = DateTime.now();
                      }

                      // add user id if all data is valid
                      widget.winchRequest.userId = _userProvider.userDate.id.toString();
                      _isLoading = true;
                      setState(() {});
                      int statue = await _winchRequestsProvider.createWinchRequest(
                        token: _userProvider.userDate.token,
                        winchRequest: widget.winchRequest,
                        language: _language
                      );
                      _isLoading = false;
                      setState(() {});
                      if(statue >= 200 && statue < 300){
                        _winchRequestsProvider.winchRequests.first.coupon = widget.winchRequest.coupon;
                        Package _package = _winchRequestsProvider.winchRequests.first.userVehicle.package;
                        if(_package != null || _package?.expiryDate?.isAfter(DateTime.now())==true){
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_)=> WinchRequestDonePage()
                              )
                          );
                        }else{
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (_)=> PaymentMethod(
                                    winchRequest: _winchRequestsProvider.winchRequests.first,
                                  )
                              )
                          );
                        }

                      }else{
                        Fluttertoast.showToast(
                            msg: HttpStatusManger.getStatusMessage(
                                status: statue, subtitle: _subtitle
                            ),
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            fontSize: 16.0
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 32,),
            ],
          ),
        ),
      ),

    );
  }
}
