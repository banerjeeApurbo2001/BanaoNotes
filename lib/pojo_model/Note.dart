import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

/// POJO for our note

class Note{
  String id;
  String title;
  var description;
  bool deleted;


  Note({
   @required this.id,
   @required this.title,
   @required this.description,
   @required this.deleted,
    this.createdAt,
 });

  Note.fromJSON(Map json) :
        id=json["id"],
        title=json["title"],
        description=json["note"],
        deleted=json["deleted"];
}