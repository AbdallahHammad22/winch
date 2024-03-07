import 'dart:convert';

class AppNotification{
  String id;
  String title;
  String body;
  Screen screen;

  AppNotification({
    this.id,
    this.title,
    this.body,
    this.screen
  });

  factory AppNotification.fromJson(Map<String,dynamic> parsedJson){
    return AppNotification(
      id: parsedJson["google.message_id"],
      title: parsedJson["title"],
      body: parsedJson["body"],
      screen: Screen.fromJson(json.decode(parsedJson["screen"])),
    );
  }
}

class Screen{
  String id;
  String path;

  Screen({
    this.id,
    this.path,
  });

  String toJson() {
    return json.encode({"id":id,"screen":path});
  }

  factory Screen.fromJson(Map<String,dynamic> parsedJson){
    return Screen(
      id: parsedJson["id"],
      path: parsedJson["screen"],
    );
  }
}