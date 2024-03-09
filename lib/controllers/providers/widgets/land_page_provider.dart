import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:winch/models/app_notification.dart';
import 'package:winch/views/user/about_us.dart';
import 'package:winch/views/user/contact_us.dart';
import 'package:winch/views/user/make_request_page.dart';
import 'package:winch/views/user/packages_page.dart';
import 'package:winch/views/user/privacy_policy.dart';
import 'package:winch/views/user/user_cars.dart';
import 'package:winch/views/user/winch_requests_page.dart';

class LandPageProvider extends ChangeNotifier{

  reset(){
    _index = 2;
    notifyListeners();
  }

  void goToPath(BuildContext context,Screen screen){
    if(screen.path == AboutUs.id){
      _index = 6;
    }else if(screen.path == ContactUs.id){
      _index = 4;
    }else if(screen.path == WinchRequestsPage.id){
      _index = 3;
      if(screen.id != null){
        Navigator.of(context).pushNamed(
            screen.path,
            arguments: screen.id
        );
      }
    }else if(screen.path == MakeRequestPage.id){
      _index = 2;
    }else if(screen.path == PackagesPage.id){
      _index = 0;
    }else if(screen.path == UserCars.id){
      _index = 1;
      if(screen.id != null){
        Navigator.of(context).pushNamed(
            screen.path,
            arguments: screen.id
        );
      }
    }else if(screen.path == PrivacyPolicy.id){
      _index = 5;
    }
    notifyListeners();
  }

  int _index = 2;
  int get index => _index;
  set index(int index) {
    _index = index;
    notifyListeners();
  }

}