import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

/// POJO for our note

class Note{
  String id;
  String title;
  var description;
  bool deleted;
  Timestamp createdAt = Timestamp.now();
  var url;

  Note({
   @required this.id,
   @required this.title,
   @required this.description,
   @required this.deleted,
    this.createdAt, this.url
 });

  Note.fromJSON(Map<String , dynamic> json) {
    id = json["id"];
    title=json["title"];
    description=json["note"];
    deleted=(json["deleted"].runtimeType==int)?(json["deleted"]==0)?false:true:json["deleted"];
    url= json["url"];
  }

  Map<String, Object> toJson()=> {
    NoteFields.id:id,
    NoteFields.title:title,
    NoteFields.note:description,
    NoteFields.deleted:deleted?1:0,
    NoteFields.url:url
  };
}

class NoteFields{
  static String id="id";
  static String title="title";
  static String note="note";
  static String deleted="deleted";
  static String url="url";
}
