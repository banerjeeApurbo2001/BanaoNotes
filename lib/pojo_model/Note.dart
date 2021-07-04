import 'package:flutter/cupertino.dart';

/// POJO for our note

class Note{
  String id;
  String title;
  String description;
  bool deleted;
  DateTime createdAt;

  Note({
   @required this.id,
   @required this.title,
   @required this.description,
   @required this.deleted,
    @required this.createdAt,
 });

  Note.fromJSON(Map json) :
        id=json["id"],
        title=json["title"],
        description=json["description"],
        deleted=json["deleted"],
        createdAt=json["createdAt"];
}