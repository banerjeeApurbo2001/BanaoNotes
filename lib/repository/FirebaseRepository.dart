import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:notekeeperatg/data_provider/DatabaseService.dart';
import 'package:notekeeperatg/data_provider/FirebaseService.dart';
import 'package:notekeeperatg/pojo_model/Note.dart';

class FirebaseRepository{
  final FirebaseService service;

  FirebaseRepository({@required this.service});

  Future<List<Note>> fetchNotDeletedCollections() async {
    List<Note> notes;
    List<Map> rawnotes = await service.fetchNDeleted();
    print(rawnotes);
    notes = rawnotes.map((e) => Note.fromJSON(e)).toList();
    await DatabaseService.instance.insertNotDeleted(notes);
    return notes;
  }

  Future<List<Note>> fetchDeletedCollections() async {
    List<Map> rawnotes = await service.fetchDeleted();
    List<Note> notes = rawnotes.map((e) => Note.fromJSON(e)).toList();
    await DatabaseService.instance.insertDeleted(notes);
    return notes;
  }

  void deleteCollection(String id) {
    service.deleteCollection(id);
  }

  Future<bool> addData(String title, String note,String url) async {
    Note n = Note(id: "0", title: title, description: note, deleted: false, url: url);
    bool p = await service.addData(n);
    return p;
  }

  Future<bool> markTrashed(String id) async{
    return await service.markedTrashed(id);
  }

}