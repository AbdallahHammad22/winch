import 'package:winch/models/enums/user_types.dart';
import 'enums/user_gender.dart';

class User{
  String id;
  String name;
  UsersTypes type;
  Gender gender;
  String email;
  String emailCode;
  DateTime emailVerifiedAt;
  String password;
  String image;
  String phoneNumber;
  String phoneCode;
  DateTime phoneVerifiedAt;
  DateTime createAt;
  DateTime updateAt;
  String token;
  String referralCode;
  String fireBaseToken;

  User({
    this.id,
    this.name,
    this.gender = Gender.male,
    this.email,
    this.emailCode,
    this.emailVerifiedAt,
    this.image,
    this.phoneNumber,
    this.phoneCode,
    this.phoneVerifiedAt,
    this.createAt,
    this.updateAt,
    this.token,
    this.fireBaseToken,
    this.referralCode,
  });

  Map<String,dynamic> toLoginJson(){
    Map<String,dynamic> jsonObject = {};
    if(email != null)
      jsonObject["email"] = email;
    if(phoneNumber != null)
      jsonObject["phone"] = phoneNumber;
    if(password != null)
      jsonObject["password"] = password;
    return jsonObject;
  }

  Map<String,dynamic> toRegisterJson(){
    Map<String,dynamic> body = {};
    if(name != null)
      body["name"] = name;
    if(email != null)
      body["email"] = email;
    if(password != null){
      body["password"] = password;
      body["password_confirmation"] = password;
    }
    if(phoneNumber != null)
      body["phone"] = phoneNumber;
    if(gender != null)
      body["gender"] = gender.toString().split(".").last;
    if(type != null)
      body["type"] = "user";
    if(fireBaseToken != null)
      body["fcm_token"] = fireBaseToken;
    if(referralCode != null)
      body["registered_referral_code"] = "123456";

    return body;
  }

  Map<String,dynamic> toJson(){
    print(type);
    return {
      "id":id,
      "name": name,
      "email":email,
      "phone":phoneNumber,
      "password":password,
      "image":image,
      "access_token":token,
      "fcm_token":fireBaseToken,
      "referral_code":referralCode,
    };
  }

  factory User.fromJson(Map<String,dynamic> parsedJson){
    return User(
      id: parsedJson["user"]["id"].toString(),
      name: parsedJson["user"]["name"],
      email: parsedJson["user"]["email"],
      emailCode: parsedJson["user"]["email_code"],
      emailVerifiedAt: parsedJson["user"]["email_verified_at"] != null
          ? DateTime.tryParse(parsedJson["user"]["email_verified_at"])
          : null,
      image: parsedJson["user"]["image"],
      phoneNumber: parsedJson["user"]["phone"],
      phoneCode: parsedJson["user"]["phone_code"],
      phoneVerifiedAt: parsedJson["user"]["phone_verified_at"] != null
        ? DateTime.tryParse(parsedJson["user"]["phone_verified_at"])
        : null,
      createAt: DateTime.tryParse(parsedJson["user"]["created_at"] ?? ''),
      updateAt: DateTime.tryParse(parsedJson["user"]["updated_at"] ?? ''),
      token: parsedJson["access_token"],
      referralCode: parsedJson["user"]["referral_code"],
    );
  }

  factory User.fromSettingJson(Map<String,dynamic> parsedJson){
    return User(
        id: parsedJson["id"].toString(),
        name: parsedJson["name"],
        email: parsedJson["email"],
        emailCode: parsedJson["email_code"],
        emailVerifiedAt: parsedJson["email_verified_at"] != null
            ? DateTime.tryParse(parsedJson["email_verified_at"])
            : null,
        image: parsedJson["image"],
        phoneNumber: parsedJson["phone"],
        phoneCode: parsedJson["phone_code"],
        phoneVerifiedAt: parsedJson["phone_verified_at"] != null
            ? DateTime.tryParse(parsedJson["phone_verified_at"])
            : null,
        createAt: DateTime.tryParse(parsedJson["created_at"] ?? ''),
        updateAt: DateTime.tryParse(parsedJson["updated_at"] ?? ''),
        token: parsedJson["access_token"],
        fireBaseToken: parsedJson["fcm_token"],
        referralCode: parsedJson["referral_code"],
    );
  }


}