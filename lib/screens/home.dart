import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp/screens/note_editor.dart';
import 'package:notesapp/screens/note_reader.dart';
import 'package:notesapp/utils/app_styl.dart';
import 'package:notesapp/widgets/note_card.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appStyle.mainColor,
      appBar: AppBar(
        title: Text('NOTES'),
        centerTitle: true,
        backgroundColor: appStyle.mainColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your recent Notes',
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22
          ),),
          SizedBox(height: 20,),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("notes").snapshots(),
                builder: (context,AsyncSnapshot snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );

                }
                if(snapshot.hasData){
                  return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                    children:snapshot.data.docs.map<Widget>((note)=> noteCard(() => {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteReader(note)))
                    }, note)).toList(),
                      );
                }
                return Text("there is no Notes",
                  style: GoogleFonts.nunito(
                    color: Colors.white,

                ),);
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteEditor()));
          }, label: Text('Add Note'),
      icon: Icon(Icons.add,)),
    );
  }
}
