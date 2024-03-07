import 'package:meta/meta.dart';
import 'package:winch/models/subtitle.dart';

class HttpStatusManger{
  static String getStatusMessage({
    @required int status,
    @required Subtitle subtitle,
    String messageFor400,
    String messageFor200,
  }){
    if(status == null)
      // no status code - code error no need for subtitle
      return "careful null status";
    if(status == -1)
      // client's request in process
      return subtitle.currentlyServiceNotAvailable;
    if(status == -2){
      // client's request in process
      return subtitle.waitUntilYourRequestComplete;
    }else if(status >= 200 && status < 300){
      // client's request was successfully received
      return messageFor200 ?? subtitle.requestCompleteSuccessfully;
    } else if(status >= 400 && status < 500){
      // client's request have error
      switch(status){
        case 400:
          return messageFor400 ?? subtitle.failedToCompleteRequest;
        default:
          return subtitle.failedToCompleteRequest;
      }
    } else if(status >= 500){
      // server error
      return subtitle.currentlyServiceNotAvailable;
    } else {
      // no error match so return default error
      return subtitle.failedToCompleteRequest;
    }

  }
}