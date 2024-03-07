import 'package:meta/meta.dart';
import 'package:winch/models/enums/vehicle_status_types.dart';
import 'package:winch/models/enums/winch_request_types.dart';
import 'package:winch/models/user_vehicle.dart';
import 'package:winch/models/vehicle.dart';

import 'enums/winch_status_types.dart';

class Subtitle{
  // http requests status messages
  String currentlyServiceNotAvailable;
  String waitUntilYourRequestComplete;
  String requestCompleteSuccessfully;
  String failedToCompleteRequest;
  String tryAgain;

  // dialogs
  // words
  String logout;
  String exit;
  String confirm;
  String cancel;
  // phrases
  String logoutAlert;
  String exitAlert;

  // login and registration page
  // words
  String name;
  String email;
  String phoneNumber;
  String password;
  String confirmPassword;
  String male;
  String female;
  String signUp;
  String signIn;
  String forgetPassword;
  String becomeAMember;
  String language;
  String emailOrPhoneNumber;
  // phrases
  String notValidPhoneNumberOrEmail;
  String acceptTermsAndConditions;
  String acceptPrivacyPolicy;
  String acceptPrivacyPolicyIsRequired;
  String nameValidateMessage;
  String emailValidateMessage;
  String phoneNumberValidateMessage;
  String passwordValidateMessage;
  String confirmPasswordValidateMessage;
  String termsAndConditionsValidateMessage;
  String wrongEmailPhoneNumberOrPassword;
  String signInWithEmailOrPhoneAndPassword;
  String signUpWithEmailAndPhone;

  // about us page
  // words
  String aboutUs;
  String vision;
  String mission;

  // private police page
  // word
  String privacyPolicy;

  // brands
  // words - no word in brands page
  // phrases
  String noBrandsFound;

  // categories
  // words - no word in categories page
  // phrases
  String noCategoriesFound;

  // packages
  // words
  String egp;
  // phrases
  String noPackagesFound;
  String noNameFound;
  String noCostFount;
  String noDescriptionFound;
  String noDurationFound;

  // wynch requests
  // words
  String wynchRequest;
  String wynchRequests;
  String startLocation;
  String endLocation;
  String pickCar;
  String notes;
  String carInfo;
  String requestType;
  String requestInfo;
  String requestDateAndTime;
  String createRequest;
  String done;
  String status;
  String type;
  String date;
  String pickDate;
  String pick;
  String live;
  String scheduled;
  String pending;
  String started;
  String finished;
  // phrases
  String noWynchRequestsFound;
  String requiredCarToMackRequest;
  String requiredDateInScheduledRequest;
  String dateHasAlreadyPassed;
  String wynchTeamWillCallYou;
  String noCarFound;

  // cars
  // words
  String myCars;
  String back;
  String addACar;
  String edit;
  String category;
  String brand;
  String plateNumber;
  String chassisNumber;
  String motorNumber;
  String year;
  String frontCarLicence;
  String backCarLicence;
  String addAnther;
  String finish;
  String update;
  String search;
  String subscribe;
  String inReview;
  String approved;
  String rejected;
  // phrases
  String addNewCar;
  String editCarInfo;
  String noCategoryFound;
  String noBrandFound;
  String noPlateNumberFound;
  String noChassisNumberFound;
  String noMotorNumberFound;
  String noYearFound;
  String brandAlert;
  String categoryAlert;
  String carAddSuccessfully;
  String carUpdatedSuccessfully;
  String pleasePickCategoryFirst;
  String plateNumberAlert;
  String chassisAlert;
  String motorAlert;
  String yearAlert;
  String noTypeFound;
  String noStatusFound;

  // images
  // words - no words in image picker
  // phrases
  String imageAlert;
  String pickFromGallery;
  String pickFromCamera;

  // subscription
  // words
  String paymentMethods;
  String next;
  String car;
  String package;
  // phrases
  String pickCarAndPackage;
  String pleaseWaitUntilRedirectToPaymentGateway;

  // contact us
  // words
  String contactUs;
  String message;
  String send;
  // phrases
  String facebookNotAvailable;
  String instagramNotAvailable;
  String twitterNotAvailable;
  String phoneNumberNotAvailable;
  String messageValidateMessage;
  String messageDeliveredSuccessfully;

  // land page
  // words
  String packages;
  String makeRequest;
  String requests;
  String help;

  // make request
  // words
  String myLocation;
  String pickLocation;
  String price;
  // phrases
  String whereAreYou;
  String whereToGo;

  // forget password and verify phone number
  // words
  String sendSms;
  String resendSms;
  String verify;
  String code;
  String resetPassword;
  // phrases
  String forgetPasswordStep;
  String verifyPhoneNumber;
  String notValidCode;
  String accountActivateSuccessfully;
  String invalidCode;
  String smsResendSuccessfully;
  String passwordResetSuccessfully;

  // reviews
  // words
  String review;
  String reviews;
  String comment;
  String rate;
  String submit;
  String reviewService;
  // phrases
  String reviewWynchService;
  String reviewsNotFound;
  String serviceReviewSuccessfully;
  String requiredRate;

  // coupon
  // words
  String coupon;
  String addCoupon;
  String checkCoupon;
  String requiredCoupon;
  String check;
  // phrases
  String validCoupon;
  String inValidCoupon;

  // reviews
  // words
  // phrases
  String subscribeDate;
  String expiryDate;

  // intro
  // words
  String welcomeWord;
  String addCarWord;
  String subscribeWord;
  String congratulationsWord;
  String skip;
  String letsStart;
  String loading;
  String continueWord;
  // phrases
  String welcomePhrase;
  String addCarPhrase;
  String subscribePhrase;
  String congratulationsPhrase;
  String checkOutOurPackages;
  String goToPackages;
  String oneTimeRequest;

  String getRequestType(WinchRequestType type){
    switch(type){
      case WinchRequestType.live: return live;
      case WinchRequestType.scheduled: return scheduled;
      default: return noTypeFound;
    }
  }

  String getRequestStatus(WinchRequestStatus status){
    switch(status){
      case WinchRequestStatus.pending: return pending;
      case WinchRequestStatus.started: return started;
      case WinchRequestStatus.finished: return finish;
      default: return noStatusFound;
    }
  }

  String getVehicleStatus(VehicleStatus status){
    switch(status){
      case VehicleStatus.approved: return approved;
      case VehicleStatus.rejected: return rejected;
      case VehicleStatus.in_review: return inReview;
      default: return noStatusFound;
    }
  }

  Subtitle({
    @required this.currentlyServiceNotAvailable,
    @required this.failedToCompleteRequest,
    @required this.requestCompleteSuccessfully,
    @required this.waitUntilYourRequestComplete,

    @required this.logout,
    @required this.cancel,
    @required this.confirm,
    @required this.done,
    @required this.exit,
    @required this.exitAlert,
    @required this.logoutAlert,
    @required this.language,

    @required this.name,
    @required this.email,
    @required this.phoneNumber,
    @required this.password,
    @required this.forgetPassword,
    @required this.acceptTermsAndConditions,
    @required this.confirmPassword,
    @required this.male,
    @required this.female,
    @required this.signIn,
    @required this.signUp,
    @required this.nameValidateMessage,
    @required this.emailValidateMessage,
    @required this.phoneNumberValidateMessage,
    @required this.passwordValidateMessage,
    @required this.confirmPasswordValidateMessage,
    @required this.termsAndConditionsValidateMessage,

    @required this.becomeAMember,
    @required this.aboutUs,
    @required this.mission,
    @required this.vision,
    @required this.notValidPhoneNumberOrEmail,
    @required this.privacyPolicy,
    @required this.noCategoriesFound,
    @required this.noPackagesFound,
    @required this.noBrandsFound,
    @required this.wynchRequest,
    @required this.endLocation,
    @required this.startLocation,
    @required this.requestType,
    @required this.createRequest,
    @required this.dateHasAlreadyPassed,
    @required this.noWynchRequestsFound,
    @required this.pickCar,
    @required this.requestDateAndTime,
    @required this.requiredCarToMackRequest,
    @required this.requiredDateInScheduledRequest,
    @required this.wynchRequests,
    @required this.wynchTeamWillCallYou,

    @required this.pickFromGallery,
    @required this.imageAlert,
    @required this.requestInfo,
    @required this.carInfo,
    @required this.noBrandFound,
    @required this.noCategoryFound,
    @required this.plateNumber,
    @required this.brand,
    @required this.year,
    @required this.backCarLicence,
    @required this.chassisNumber,
    @required this.motorNumber,
    @required this.frontCarLicence,
    @required this.category,
    @required this.addACar,
    @required this.addAnther,
    @required this.addNewCar,
    @required this.back,
    @required this.brandAlert,
    @required this.carAddSuccessfully,
    @required this.carUpdatedSuccessfully,
    @required this.categoryAlert,
    @required this.chassisAlert,
    @required this.edit,
    @required this.editCarInfo,
    @required this.finish,
    @required this.myCars,
    @required this.noChassisNumberFound,
    @required this.noMotorNumberFound,
    @required this.noPlateNumberFound,
    @required this.noYearFound,
    @required this.pickFromCamera,
    @required this.plateNumberAlert,
    @required this.pleasePickCategoryFirst,
    @required this.update,
    @required this.yearAlert,
    @required this.status,
    @required this.type,
    @required this.date,
    @required this.noStatusFound,
    @required this.started,
    @required this.pending,
    @required this.finished,
    @required this.scheduled,
    @required this.live,
    @required this.noCarFound,
    @required this.pick,
    @required this.pickDate,
    @required this.motorAlert,
    @required this.noTypeFound,

    @required this.subscribe,
    @required this.search,
    @required this.next,
    @required this.paymentMethods,
    @required this.package,
    @required this.pickCarAndPackage,
    @required this.message,
    @required this.contactUs,
    @required this.car,
    @required this.send,
    @required this.facebookNotAvailable,
    @required this.instagramNotAvailable,
    @required this.phoneNumberNotAvailable,
    @required this.messageDeliveredSuccessfully,
    @required this.messageValidateMessage,
    @required this.twitterNotAvailable,
    @required this.packages,
    @required this.requests,
    @required this.help,
    @required this.makeRequest,
    @required this.myLocation,
    @required this.whereAreYou,
    @required this.whereToGo,

    @required this.emailOrPhoneNumber,
    @required this.wrongEmailPhoneNumberOrPassword,
    @required this.smsResendSuccessfully,
    @required this.resendSms,
    @required this.invalidCode,
    @required this.passwordResetSuccessfully,
    @required this.resetPassword,
    @required this.notValidCode,
    @required this.code,
    @required this.sendSms,
    @required this.accountActivateSuccessfully,
    @required this.pickLocation,
    @required this.forgetPasswordStep,
    @required this.verifyPhoneNumber,
    @required this.verify,
    @required this.approved,
    @required this.inReview,
    @required this.noCostFount,
    @required this.noDescriptionFound,
    @required this.noDurationFound,
    @required this.noNameFound,
    @required this.rejected,
    @required this.signInWithEmailOrPhoneAndPassword,
    @required this.signUpWithEmailAndPhone,
    @required this.egp,

    @required this.subscribeDate,
    @required this.expiryDate,
    @required this.reviewService,
    @required this.review,
    @required this.serviceReviewSuccessfully,
    @required this.requiredRate,
    @required this.submit,
    @required this.comment,
    @required this.rate,
    @required this.reviewWynchService,
    @required this.validCoupon,
    @required this.inValidCoupon,
    @required this.coupon,
    @required this.requiredCoupon,
    @required this.checkCoupon,
    @required this.reviews,
    @required this.check,
    @required this.reviewsNotFound,
    @required this.tryAgain,

    @required this.addCarPhrase,
    @required this.addCarWord,
    @required this.congratulationsPhrase,
    @required this.congratulationsWord,
    @required this.continueWord,
    @required this.skip,
    @required this.letsStart,
    @required this.loading,
    @required this.subscribePhrase,
    @required this.subscribeWord,
    @required this.welcomePhrase,
    @required this.welcomeWord,
    @required this.checkOutOurPackages,
    @required this.goToPackages,
    @required this.oneTimeRequest,
    @required this.addCoupon,
    @required this.pleaseWaitUntilRedirectToPaymentGateway,
    @required this.price,
    @required this.notes,
    @required this.acceptPrivacyPolicy,
    @required this.acceptPrivacyPolicyIsRequired,
  });

  factory Subtitle.fromJson(Map<String,dynamic> parsedJson){
    return Subtitle(
      currentlyServiceNotAvailable: parsedJson["server_error_message"],
      failedToCompleteRequest: parsedJson["failed_request_message"],
      requestCompleteSuccessfully: parsedJson["successful_request_message"],
      waitUntilYourRequestComplete: parsedJson["request_lock_message"],

      cancel: parsedJson["cancel"],
      confirm: parsedJson["confirm"],
      done: parsedJson["done"],
      exit: parsedJson["exit"],
      exitAlert: parsedJson["exit_alert"],
      logout: parsedJson["logout"],
      logoutAlert: parsedJson["logout_alert"],
      language: parsedJson["language"],

      name: parsedJson["name"],
      email: parsedJson["email"],
      phoneNumber: parsedJson["phone_number"],
      password: parsedJson["password"],
      confirmPassword: parsedJson["confirm_password"],
      signUp: parsedJson["sign_up"],
      signIn: parsedJson["sign_in"],
      female: parsedJson["female"],
      male: parsedJson["male"],
      forgetPassword: parsedJson["forget_password"],
      acceptTermsAndConditions: parsedJson["accept_terms_and_conditions"],
      emailValidateMessage: parsedJson["email_validate_message"],
      nameValidateMessage: parsedJson["name_validate_message"],
      passwordValidateMessage: parsedJson["password_validate_message"],
      confirmPasswordValidateMessage: parsedJson["confirm_password_validate_message"],
      phoneNumberValidateMessage: parsedJson["phone_number_validate_message"],
      termsAndConditionsValidateMessage: parsedJson["terms_and_conditions_validate_message"],

      aboutUs: parsedJson["about_us"],
      vision: parsedJson["vision"],
      mission: parsedJson["mission"],
      notValidPhoneNumberOrEmail: parsedJson["notValidPhoneNumberOrEmail"],
      privacyPolicy: parsedJson["privacy_policy"],
      noBrandsFound: parsedJson["no_brands_found"],
      noCategoriesFound: parsedJson["no_categories_found"],
      noPackagesFound: parsedJson["no_packages_found"],
      endLocation: parsedJson["end_location"],
      startLocation: parsedJson["start_location"],
      createRequest: parsedJson["create_request"],
      dateHasAlreadyPassed: parsedJson["date_has_already_passed"],
      noWynchRequestsFound: parsedJson["no_wynch_requests_found"],
      pickCar: parsedJson["pick_car"],
      requestDateAndTime: parsedJson["request_date_and_time"],
      requestType: parsedJson["request_type"],
      requiredCarToMackRequest: parsedJson["required_car_to_make_request"],
      requiredDateInScheduledRequest: parsedJson["required_date_in_scheduled_request"],
      wynchRequest: parsedJson["wynch_request"],
      wynchRequests: parsedJson["wynch_requests"],
      wynchTeamWillCallYou: parsedJson["wynch_team_will_call_you"],

      frontCarLicence: parsedJson["front_car_licence"],
      backCarLicence: parsedJson["back_car_licence"],
      plateNumber: parsedJson["plate_number"],
      category: parsedJson["category"],
      addACar: parsedJson["add_a_car"],
      addAnther: parsedJson["add_anther"],
      addNewCar: parsedJson["add_new_car"],
      back: parsedJson["back"],
      brand: parsedJson["brand"],
      brandAlert: parsedJson["brand_alert"],
      carAddSuccessfully: parsedJson["car_add_successfully"],
      carInfo: parsedJson["car_info"],
      carUpdatedSuccessfully: parsedJson["car_updated_successfully"],
      categoryAlert: parsedJson["category_alert"],
      chassisAlert: parsedJson["chassis_alert"],
      chassisNumber: parsedJson["chassis_number"],
      edit: parsedJson["edit"],
      editCarInfo: parsedJson["edit_car_info"],
      finish: parsedJson["finish"],
      imageAlert: parsedJson["image_alert"],
      motorNumber: parsedJson["motor_number"],
      myCars: parsedJson["my_cars"],
      noBrandFound: parsedJson["no_brand_found"],
      noCategoryFound: parsedJson["no_category_found"],
      noChassisNumberFound: parsedJson["no_chassis_number_found"],
      noMotorNumberFound: parsedJson["no_motor_number_found"],
      noPlateNumberFound: parsedJson["no_plate_number"],
      noYearFound: parsedJson["no_year_found"],
      pickFromCamera: parsedJson["pick_from_camera"],
      pickFromGallery: parsedJson["pick_from_gallery"],
      plateNumberAlert: parsedJson["plate_number_alert"],
      pleasePickCategoryFirst: parsedJson["please_pick_category_first"],
      requestInfo: parsedJson["request_info"],
      update: parsedJson["update"],
      year: parsedJson["year"],
      yearAlert: parsedJson["year_alert"],
      status: parsedJson["status"],
      date: parsedJson["date"],
      type: parsedJson["type"],

      finished: parsedJson["finished"],
      live: parsedJson["live"],
      motorAlert: parsedJson["motor_alert"],
      noCarFound: parsedJson["no_car_found"],
      noStatusFound: parsedJson["no_status_found"],
      noTypeFound: parsedJson["no_type_found"],
      pending: parsedJson["pending"],
      pick: parsedJson["pick"],
      pickDate: parsedJson["pickDate"],
      scheduled: parsedJson["scheduled"],
      started: parsedJson["started"],

      message: parsedJson["message"],
      package: parsedJson["package"],
      search: parsedJson["search"],
      car: parsedJson["car"],
      contactUs: parsedJson["contact_us"],
      facebookNotAvailable: parsedJson["facebook_not_available"],
      instagramNotAvailable: parsedJson["instagram_not_available"],
      messageDeliveredSuccessfully: parsedJson["message_delivered_successfully"],
      messageValidateMessage: parsedJson["message_validate_message"],
      next: parsedJson["next"],
      paymentMethods: parsedJson["payment_methods"],
      phoneNumberNotAvailable: parsedJson["phone_Number_not_available"],
      pickCarAndPackage: parsedJson["pick_car_and_package"],
      send: parsedJson["send"],
      subscribe: parsedJson["subscribe"],
      twitterNotAvailable: parsedJson["twitter_not_available"],
      becomeAMember: parsedJson["become_member"],
      help: parsedJson["help"],
      makeRequest: parsedJson["make_request"],
      packages: parsedJson["packages"],
      requests: parsedJson["requests"],
      myLocation: parsedJson["my_location"],
      whereAreYou: parsedJson["where_are_you"],
      whereToGo: parsedJson["where_to_go"],

      code: parsedJson["code"],
      accountActivateSuccessfully: parsedJson["account_activate_successfully"],
      emailOrPhoneNumber: parsedJson["email_or_phone_number"],
      forgetPasswordStep: parsedJson["forget_password_step"],
      invalidCode: parsedJson["invalid_code"],
      notValidCode: parsedJson["not_valid_code"],
      passwordResetSuccessfully: parsedJson["password_reset_successfully"],
      pickLocation: parsedJson["pick_location"],
      resendSms: parsedJson["resend_sms"],
      resetPassword: parsedJson["reset_password"],
      sendSms: parsedJson["send_sms"],
      smsResendSuccessfully: parsedJson["sms_resend_successfully"],
      verify: parsedJson["verify"],
      verifyPhoneNumber: parsedJson["verify_phone_number"],
      wrongEmailPhoneNumberOrPassword: parsedJson["wrong_email_phone_number_or_Password"],
      approved: parsedJson["approved"],
      inReview: parsedJson["in_review"],
      noCostFount: parsedJson["no_cost_fount"],
      noDescriptionFound: parsedJson["no_description_found"],
      noDurationFound: parsedJson["no_duration_found"],
      noNameFound: parsedJson["no_name_found"],
      rejected: parsedJson["rejected"],
      signInWithEmailOrPhoneAndPassword: parsedJson["sign_in_with_email_or_phone_and_password"],
      signUpWithEmailAndPhone: parsedJson["sign_up_with_email_and_phone"],
      egp: parsedJson["egp"],

      review: parsedJson["review"],
      coupon: parsedJson["coupon"],
      check: parsedJson["check"],
      checkCoupon: parsedJson["check_coupon"],
      comment: parsedJson["comment"],
      expiryDate: parsedJson["expiry_date"],
      rate: parsedJson["rate"],
      requiredCoupon: parsedJson["required_coupon"],
      requiredRate: parsedJson["required_rate"],
      reviews: parsedJson["reviews"],
      reviewService: parsedJson["review_service"],
      reviewsNotFound: parsedJson["reviews_not_found"],
      reviewWynchService: parsedJson["review_wynch_service"],
      serviceReviewSuccessfully: parsedJson["service_review_successfully"],
      submit: parsedJson["submit"],
      subscribeDate: parsedJson["subscribe_date"],
      tryAgain: parsedJson["try_again"],
      validCoupon: parsedJson["valid_coupon"],
      inValidCoupon: parsedJson["invalid_coupon"],

      addCarPhrase: parsedJson["add_car_phrase"],
      addCarWord: parsedJson["add_car_word"],
      congratulationsPhrase: parsedJson["congratulations_phrase"],
      congratulationsWord: parsedJson["congratulations_word"],
      continueWord: parsedJson["continue_word"],
      skip: parsedJson["skip"],
      letsStart: parsedJson["lets_start"],
      loading: parsedJson["loading"],
      subscribePhrase: parsedJson["subscribe_phrase"],
      subscribeWord: parsedJson["subscribe_word"],
      welcomePhrase: parsedJson["welcome_phrase"],
      welcomeWord: parsedJson["welcome_word"],
      checkOutOurPackages: parsedJson["check_out_our_packages"],
      goToPackages: parsedJson["go_to_packages"],
      oneTimeRequest: parsedJson["one_time_request"],
      addCoupon: parsedJson["add_coupon"],
      pleaseWaitUntilRedirectToPaymentGateway: parsedJson["pay_alert"],
      price: parsedJson["price"],
      notes: parsedJson["notes"],
      acceptPrivacyPolicy: parsedJson["acceptPrivacyPolicy"],
      acceptPrivacyPolicyIsRequired: parsedJson["acceptPrivacyPolicyIsRequired"],
    );
  }

}