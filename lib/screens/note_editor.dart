import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/utils/app_styl.dart';
class NoteEditor extends StatefulWidget {
  const NoteEditor({Key? key}) : super(key: key);

  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  String date= DateTime.now().toString();
  TextEditingController titleController = TextEditingController();
  TextEditingController MainController = TextEditingController();
  int color_id = Random().nextInt(appStyle.cardsColor.length);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: appStyle.cardsColor[color_id],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Add a new Note",
        style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             TextField(
               controller: titleController,
               decoration: InputDecoration(
                 border: InputBorder.none,
                 hintText: 'Note Title'
               ),style: appStyle.mainTitle,
             ),
             SizedBox(height: 8,),
             Text(date,style:appStyle.dateTitle ,),
             SizedBox(height: 28,),
             TextField(
               controller: MainController,
               keyboardType: TextInputType.multiline,
               maxLines: null,
               decoration: InputDecoration(
                   border: InputBorder.none,
                   hintText: 'Note content'
               ),style: appStyle.mainContent,
             ),
           ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          FirebaseFirestore.instance.collection("notes").add({
            "note_title": titleController.text,
            "creation_date": date,
            "note_content": MainController.text,
            "color_id": color_id,
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError(
              (error)=> print("failed to add new note due to $error")
          );
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
