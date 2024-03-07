import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/http_status_manger/http_status_manger.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/controllers/providers/api/winch_requests_provider.dart';
import 'package:winch/models/enums/winch_request_types.dart';
import 'package:winch/models/enums/winch_status_types.dart';
import 'package:winch/models/review.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/models/user_vehicle.dart';
import 'package:winch/models/winch_request.dart';
import 'package:winch/pages/requests/request_done_page.dart';
import 'package:winch/pages/requests/review_winch_service.dart';
import 'package:winch/pages/subscription/payment_method.dart';
import 'package:winch/pages/winch_service_reviews/winch_service_reviews_children.dart';
import 'package:winch/widgets/buttons/app_button.dart';
import 'package:winch/widgets/day_and_time/date_picker.dart';
import 'package:winch/widgets/info_row.dart';
import 'package:winch/widgets/loaders/loading_manager.dart';
import 'package:winch/widgets/maps/app_map.dart';
import 'package:winch/widgets/maps/view_location.dart';
import 'package:winch/widgets/titles/app_sub_title.dart';
import 'package:winch/widgets/titles/app_title.dart';
import 'package:winch/widgets/user_vehicles/user_vechicls_picker.dart';
import 'package:winch/widgets/user_vehicles/user_vehicles_item.dart';
import 'package:winch/widgets/user_vehicles/vehicle_summery.dart';
import 'package:winch/widgets/winch_requests/status_label.dart';
import 'package:winch/widgets/winch_requests/toggle_winch_request_type.dart';
import 'package:winch/widgets/winch_requests/type_label.dart';
class WinchRequestDetails extends StatefulWidget {
  final WinchRequest winchRequest;

  const WinchRequestDetails({Key key, this.winchRequest}) : super(key: key);
  @override
  _WinchRequestDetailsState createState() => _WinchRequestDetailsState();
}

class _WinchRequestDetailsState extends State<WinchRequestDetails>
    with TickerProviderStateMixin {
  Size _size;
  bool _isLoading = false;
  UserProvider _userProvider;
  Subtitle _subtitle;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    _userProvider = Provider.of<UserProvider>(context);
    //_language = WinchLocalization.of(context).locale.languageCode;
    _subtitle = WinchLocalization.of(context).subtitle;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        title:  Image(
          image: AssetImage("assets/images/logo_horizontal.png"),
        ),
      ),
      body: LoadingManager(
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
              child: ASubTitle(_subtitle.carInfo),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: VehicleSummery(userVehicle: widget.winchRequest.userVehicle,)
            ),
            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ASubTitle(_subtitle.requestInfo),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 4
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8
              ),
              decoration: BoxDecoration(
                  color: AColors.lightGrey,
                  boxShadow: [
                    BoxShadow(
                        color: AColors.grey,
                        blurRadius: 10,
                        offset: Offset(0,5)
                    )
                  ]
              ),
              child: Column(
                children: [
                  InfoRow(
                    title: _subtitle.status,
                    infoAsWidget: WinchRequestStatusLabel(
                      status: widget.winchRequest.winchRequestStatus,
                    ),
                  ),
                  InfoRow(
                    title: _subtitle.type,
                    infoAsWidget: WinchRequestTypeLabel(
                      type: widget.winchRequest.winchRequestType,
                    ),
                  ),
                  widget.winchRequest.price != null ?
                  InfoRow(
                    title: _subtitle.price,
                    info: widget.winchRequest.price +" "+ _subtitle.egp,
                  ) : SizedBox.shrink(),
                  InfoRow(
                    title: _subtitle.date,
                    info: DateFormat.yMd().add_jm().format(widget.winchRequest.date),
                    hideDivider: true,
                  ),

                ],
              ),
            ),
            SizedBox(height: 16,),
            widget.winchRequest.price == 0 ||
            widget.winchRequest.userVehicle.package == null ||
            widget.winchRequest.userVehicle.package?.expiryDate?.isBefore(DateTime.now()) == true?
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width /1.3,
                  child: AButton(
                    text: _subtitle.paymentMethods,
                    onPressed: () async {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_)=> PaymentMethod(
                                winchRequest: widget.winchRequest,
                              )
                          )
                      );
                    },
                  ),
                ),
              ),
            ):SizedBox.shrink(),
            widget.winchRequest.winchRequestStatus == WinchRequestStatus.finished?
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ASubTitle(_subtitle.reviews),
                ),
                widget.winchRequest.reviews == null || widget.winchRequest.reviews.length == 0 ?
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width /1.3,
                    child: AButton(
                      text: _subtitle.reviewService,
                      onPressed: () async {
                        WinchServiceReview _reviw = await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_)=> ReviewWinchService(review: WinchServiceReview(
                                  userId: _userProvider.userDate.id,
                                  requestId: widget.winchRequest.id.toString(),
                                ),)
                            )
                        ) as WinchServiceReview;
                        widget.winchRequest.reviews.insert(0, _reviw);
                        setState(() {});
                      },
                    ),
                  ),
                ):
                WinchServiceReviewsChildren(reviews: widget.winchRequest.reviews,),
                SizedBox(height: 16,),
              ],
            ):SizedBox.shrink(),
            //WinchServiceReviewsChildren(reviews: widget.winchRequest.reviews,),
            SizedBox(height: 32,),
          ],
        ),
      ),

    );
  }
}
