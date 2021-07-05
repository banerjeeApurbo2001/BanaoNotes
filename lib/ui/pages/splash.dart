import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notekeeperatg/blocs/add_data.dart';
import 'package:notekeeperatg/data_provider/FirebaseService.dart';
import 'package:notekeeperatg/repository/FirebaseRepository.dart';

import 'notes_home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  FirebaseRepository repository = FirebaseRepository(service: FirebaseService(init: "Firebase"));
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => NotesHomPage())));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (context) => Add(repository: repository),

      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
                child: Image.asset('assets/splash.png',
                height: 200,
                width: 200,),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                child: Text("Banao Notes",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}