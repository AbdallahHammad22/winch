class WinchServiceReview{
  String id;
  String requestId;
  String userId;
  double rate;
  String comment;
  DateTime date;

  WinchServiceReview({
    this.id,
    this.requestId,
    this.userId,
    this.rate,
    this.comment,
    this.date,
  });

  fromReview(WinchServiceReview newReview){
    id = newReview.id;
    requestId = newReview.requestId;
    userId = newReview.userId;
    rate = newReview.rate;
    comment = newReview.comment;
    date = newReview.date;
  }

  toJson(){
    Map<String,String> jsonObject = {};
    if(id != null)
      jsonObject["id"] = id;
    if(requestId != null)
      jsonObject["request_id"] = requestId;
    if(userId != null)
      jsonObject["user_id"] =userId;
    if(rate != null)
      jsonObject["rate"] = rate.toString();
    if(comment != null)
      jsonObject["comment"] = comment;
    return jsonObject;
  }

  factory WinchServiceReview.fromJson(Map<String,dynamic> parsedJson){
    return WinchServiceReview(
      id: parsedJson["id"].toString(),
      requestId: parsedJson["request_id"].toString(),
      userId: parsedJson["user_id"].toString(),
      rate: double.tryParse(parsedJson["rate"].toString()),
      comment: parsedJson["comment"],
      date: DateTime.tryParse(parsedJson["updated_at"] ?? ""),
    );
  }
}