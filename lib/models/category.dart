import 'brand.dart';

class Category{
  int id;
  String name;
  String description;
  String image;
  List<Brand> brands;

  Category({
    this.id,
    this.name,
    this.description,
    this.image,
    this.brands
  });

  factory Category.fromJson(Map<String,dynamic> parsedJson){
   // List brandMappedList = parsedJson["brands"];
   // List<Brand> brandsList = brandMappedList.map((brand) => Brand.fromJson(brand)).toList();
    return Category(
      id: parsedJson["id"],
      name: parsedJson["name"],
      description: parsedJson["description"],
      image: parsedJson["image"],
    //  brands:brandsList,
    );
  }
}