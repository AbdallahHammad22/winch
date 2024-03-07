class Package{
  int id;
  String name;
  String description;
  double price;
  String duration;
  DateTime startDate;
  DateTime expiryDate;

  Package({
    this.id,
    this.name,
    this.description,
    this.price,
    this.duration,
    this.startDate,
    this.expiryDate,
  });

  factory Package.fromJson(Map<String,dynamic> parsedJson){
    return Package(
      id: parsedJson["id"],
      name: parsedJson["name"],
      description: parsedJson["description"],
      price: double.tryParse(parsedJson["cost"].toString()),
      duration: parsedJson["duration"].toString(),
      startDate: DateTime.tryParse(parsedJson["subscriped_at"] ?? ""),
      expiryDate: DateTime.tryParse(parsedJson["subscripe_ends_at"] ?? ""),
    );
  }
}