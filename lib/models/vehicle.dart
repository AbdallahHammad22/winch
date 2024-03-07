class Vehicle{
  int id;
  String name;
  String description;
  int userId;
  String image;

  Vehicle({
    this.id,
    this.description,
    this.name,
    this.userId,
    this.image
  });

  factory Vehicle.fromJson(Map<String,dynamic> parsedJson){
    return Vehicle(
      id: parsedJson["id"],
      userId: parsedJson["user_id"],
      name:  parsedJson["name"],
      description: parsedJson["plate_number"],
      image: parsedJson["image"],
    );
  }
}