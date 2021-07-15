import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notekeeperatg/blocs/add_data.dart';
import 'package:notekeeperatg/data_provider/FirebaseService.dart';
import 'package:notekeeperatg/pojo_model/Note.dart';
import 'package:notekeeperatg/repository/FirebaseRepository.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatelessWidget {
  AddNotePage({Key key}) : super(key: key);
  TextEditingController title=TextEditingController(),
      description = TextEditingController(),
      url = TextEditingController();
  FirebaseRepository repository = FirebaseRepository(service: FirebaseService(init: "Firebase"));
  // final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => Add(repository: repository),
      child: Scaffold(
          appBar: AppBar(title: Text("Add Note"),),
          body: BlocBuilder<Add, AddDataFirestoreState>(
            builder: (context, state) {
              if(state is AddDataFirestoreInitial)
              {
                return Form(
                  // key: key,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _titleText(),
                          SizedBox(height: 10.0,),
                          _noteText(),
                          SizedBox(height: 10.0,),
                          _videoCheck(context,state.checkedState),
                          SizedBox(height: 10.0,),
                          (state.checkedState)?_urlInput(context):Text(""),
                          SizedBox(height: 10.0,),
                          _submitButton(context)
                        ],
                      ),
                    ),
                  ),
                );
              }

              if(state is AddDataFirestoreAdding){
                return Center(child: Text("Done"),);
              }

              if(state is AddDataFirestoreAdded){
                // return Center(child: Text(state.status.toString()));
                if(state.status)
                  return Center(child: Text("Note Added Successfully"),);
                else
                  return Center(child: Text("Something went Wrong"),);
              }
              return Text("Hello");
            },
          )
      ),
    );
  }

  Widget _noteText() {
    return TextFormField(
      controller: description,
      decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Note"),
      keyboardType: TextInputType.multiline,
      maxLines: 10,
      validator: (value){
        if(value == null || value.trim().isEmpty)
          return "Note field is mandatory";
        return null;
      },

    );
  }

  Widget _titleText() {
    return TextFormField(
      controller: title,
      decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Title"),
    );
  }


  Widget _urlInput(BuildContext context) {
    return TextFormField(controller: url,decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Url"),);
  }

  Widget _submitButton(context) {
    return FloatingActionButton(onPressed:(){
      BlocProvider.of<Add>(context).addData(title.text.toString(),description.text.toString(),url.text.toString());
    }, child: Icon(Icons.check), );
  }

Widget _videoCheck(context,checkedState) {
  return CheckboxListTile(value: checkedState, onChanged: (checkState){
    BlocProvider.of<Add>(context).setCheckStateChange(checkState);
  },title: Text("Add Video Url"),);
}


}