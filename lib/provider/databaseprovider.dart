import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes_app_with_database_and_provider/database/database.dart';
import 'package:notes_app_with_database_and_provider/database/model/notesmodel.dart';
import 'package:notes_app_with_database_and_provider/screens/add_notes.dart';

class DatabaseProvider with ChangeNotifier {
  var isUpdate = false;
  late MyDatabase db;
  var titleController = TextEditingController();
  var discriptionController = TextEditingController();

  List<NotesModel> data = [];

  void facthDataToGrid() async {
    db = await MyDatabase.instance;
    data = await db.facthData();
    data.reversed;
    notifyListeners();
  }

  var currentDate =
      '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
  void addnotesToList(context) async {
    if (titleController.text.isNotEmpty &&
        discriptionController.text.isNotEmpty) {
      print('Notes added');
      var db = MyDatabase.instance;

      db.createNotes(await NotesModel(
          modelId: 0,
          modelDate: currentDate,
          modelTitle: titleController.text.toString(),
          modelDescription: discriptionController.text.toString()));
      Navigator.pop(context);
      titleController.clear();
      discriptionController.clear();
    }
    notifyListeners();
  }

  void deleteToList(int id, context) {
    Timer(Duration(milliseconds: 500), () {
      showDialog(
          context: context,
          builder: (context) => AlertDialog.adaptive(
                title: Text('You Want To Delete This Note'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('No')),
                  TextButton(
                      onPressed: () {
                        var db = MyDatabase.instance;
                        db.deleteNotes(id);
                        Navigator.pop(context);
                      },
                      child: Text('Yes'))
                ],
              ));
    });
  }

  void fieldValueToupdate(index) {
    titleController.text = data[index].modelTitle.toString();
    discriptionController.text = data[index].modelDescription.toString();
  }

  void fieldValueToNull(index) {
    titleController.text = '';
    discriptionController.text = '';
  }

  void navigatorToUpdatePage(context, mindex) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddNotesScreens(
                  mindex: mindex,
                )));
  }

  void updateToList(index, context) async {
    var db = MyDatabase.instance;
    db.updateNotes(await NotesModel(
        modelId: data[index].modelId,
        modelDate: currentDate,
        modelTitle: titleController.text.toString(),
        modelDescription: discriptionController.text.toString()));
    Navigator.pop(context);
  }
  
}
