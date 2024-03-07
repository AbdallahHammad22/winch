class Brand{
  int id;
  String name;
  String description;
  String image;

  Brand({
    this.id,
    this.name,
    this.description,
    this.image
  });

  factory Brand.fromJson(Map<String,dynamic> parsedJson){
    return Brand(
      id: parsedJson["id"],
      name: parsedJson["name"],
      description: parsedJson["description"],
      image: parsedJson["image"],
    );
  }
}