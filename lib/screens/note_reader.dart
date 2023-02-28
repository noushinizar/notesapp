import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/utils/app_styl.dart';
class NoteReader extends StatefulWidget {
   NoteReader(this.doc,{Key? key}) : super(key: key);

  QueryDocumentSnapshot doc;

  @override
  State<NoteReader> createState() => _NoteReaderState();
}

class _NoteReaderState extends State<NoteReader> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: appStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: appStyle.cardsColor[color_id],
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
             widget.doc["note_title"],
              style: appStyle.mainTitle,
            ),
            SizedBox(height: 10),
            Text(
              widget.doc["creation_date"],
              style: appStyle.dateTitle,
            ),
            SizedBox(height: 28),
            Text(
              widget.doc['note_content'],
              style: appStyle.mainContent,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
