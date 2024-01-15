import 'package:flutter/cupertino.dart';


class Todo {
  String title;
  String description;
  late bool isDone;

  Todo({
    required this.title,
    required this.description ,
    this.isDone = false,
  });


  Todo.fromMap(Map map)        
      : this.title = map["title"],
        this.description = map["description"];

  Map toMap() {              
    return {
      "title": this.title,
      "description": this.description,
    };
  }

}