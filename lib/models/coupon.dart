class Coupon{
  String id;
  String title;
  String code;
  double percent;
  double maxAmount;

  Coupon({
    this.id,
    this.title,
    this.code,
    this.maxAmount,
    this.percent,
  });

  double getDiscount(double price){
    double _discount = price * percent / 100;
    if(_discount > maxAmount)
      _discount = maxAmount;
    return _discount;
  }

  toJson(){
    return {
      "code":code,
    };
  }

  factory Coupon.fromJson(Map<String,dynamic> parsedJson){
    return Coupon(
      id: parsedJson["id"].toString(),
      title: parsedJson["title"],
      code: parsedJson["code"],
      percent: double.tryParse(parsedJson["discount"].toString()),
      maxAmount: double.tryParse(parsedJson["max_discount"].toString()),
    );
  }
}