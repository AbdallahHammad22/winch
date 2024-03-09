import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:winch/controllers/app_style/sizing.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/user_provider.dart';
import 'package:winch/controllers/providers/api/user_vehicles_provider.dart';
import 'package:winch/controllers/providers/api/winch_requests_provider.dart';
import 'package:winch/models/subtitle.dart';
import 'package:winch/views/user/land_page.dart';
class PayPage extends StatefulWidget {
  final String url;
  final String popTo;

  const PayPage({Key key, this.url, this.popTo}) : super(key: key);
  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  bool endPayment = false;
  UserProvider _userProvider;
  UserVehiclesProvider _userVehiclesProvider;
  WinchRequestsProvider _winchRequestsProvider;
  String _language;
  Subtitle _subtitle;
  @override
  Widget build(BuildContext context) {
    _userProvider = Provider.of<UserProvider>(context);
    _userVehiclesProvider = Provider.of<UserVehiclesProvider>(context);
    //_winchRequestsProvider = Provider.of<WinchRequestsProvider>(context);
    _language = WinchLocalization.of(context).locale.languageCode;
    _subtitle = WinchLocalization.of(context).subtitle;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        backgroundColor: Theme.of(context).accentColor,
        leading: IconButton(
          icon: Icon(
              endPayment
                  ? Icons.home_rounded
                  : Icons.cancel,
            size: 32 * AStyling.getScaleFactor(context),
          ),
          onPressed: (){
            if(endPayment){
              Navigator.of(context).popUntil(ModalRoute.withName( widget.popTo ?? LandPage.id));
            }else{
              Navigator.of(context).pop();
            }
          },
        ),
        title:  Image(
          image: AssetImage("assets/images/logo_horizontal.png"),
        ),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebResourceError: (error){
          print(error.description);
          print(error.errorType);
          print(error.domain);
          print(error.failingUrl);
          print(error.errorCode);
        },
        onPageStarted:(String url) async {

          String path = Uri.parse(url).path;
          if(path=="/api/successCallbackPayment"){
            _userVehiclesProvider.reset();
            await _userVehiclesProvider.getUserVehicles(
                token: _userProvider.userDate.token,
                userId: _userProvider.userDate.id,
                language: _language
            );
            endPayment = true;
            setState(() {});
          }
        }
      ),
    );
  }
}
