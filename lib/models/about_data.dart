class AboutData{
  String phone1;
  String phone2;
  String email;
  String facebook;
  String instagram;
  String twitter;
  String bio;
  String mission;
  String vision;

  AboutData({
    this.phone1,
    this.phone2,
    this.email,
    this.facebook,
    this.instagram,
    this.twitter,
    this.bio,
    this.mission,
    this.vision,
  });

  factory AboutData.fromJson(Map<String,dynamic> parsedJson){
    return AboutData(
      phone1: parsedJson["call_number"],
      phone2: parsedJson["sitePhone"],
      email: parsedJson["siteEmail"],
      facebook: parsedJson["facebook"],
      instagram: parsedJson["instagram"],
      twitter: parsedJson["twitter"],
      bio: parsedJson["about_us"],
      vision: parsedJson["terms_vision"],
      mission: parsedJson["terms_mission"],
    );
  }
}