class AError{
  String phone;
  String email;

  AError({
    this.phone,
    this.email,
  });

  factory AError.fromJson(Map<String,dynamic> parsedJson){
    return AError(
      phone: parsedJson["phone"]?.join("\n"),
      email: parsedJson["email"]?.join("\n"),
    );
  }
}