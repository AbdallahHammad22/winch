class URLs{
  URLs._();
  // API domain name
  static final host = "http://dev.wynchegypt.com/api";
  //static final host = "http://wynchegypt.ahmedabdelraouf.com/api";
  // API Routes
  // user section
  static final login = "$host/login"; // post
  static final register = "$host/register"; // post
  static final verifyPhoneNumber = "$host/verifyPhone"; // post
  static final sendCodeToPhoneNumber = "$host/sendCode"; // post
  static final forgetPassword = "$host/forgetPassword"; // post
  static final getUserVehicles = "$host/getUserVehicles"; // get
  static final getSingleUserVehicles = "$host/get-user-vehicle-details"; // get
  static final addUserVehicles = "$host/userVehicles"; // post
  static final updateUserVehicles = "$host/userVehicles/update"; // post
  // Categories with Brand
  static final getCategories = "$host/category"; // get
  // Vehicles
  static final getBrandVehicles = "$host/brandVehicles"; // get
  // package
  static final getPackages = "$host/package"; // get
  // subscription
  static final getPaymentUrl = "$host/createPaymentURL"; // get
  static final getCoupon = "$host/check-coupon"; // get
  // winch requests
  static final getWinchRequests = "$host/get-requests"; // get
  static final getSingleWinchRequest = "$host/get-request-wynch-details"; // get
  static final createWinchRequest = "$host/make/request"; // post
  static final reviewWinchServiceRequest = "$host/reviewes"; // post
  // about app
  static final getAbout = "$host/settings"; // get
  static final contactUs = "$host/contact-us"; // get
  static final getPrivacyPolicy = "$host/policies"; // get
  static final getTermsAndConditions = "$host/terms-and-conditions"; // get
}