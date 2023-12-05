import 'package:flutter/material.dart';
import 'package:notes_app_with_database_and_provider/database/database.dart';
import 'package:notes_app_with_database_and_provider/database/model/notesmodel.dart';
import 'package:notes_app_with_database_and_provider/screens/add_notes.dart';

class DatabaseProvider with ChangeNotifier {
  var isUpdate = false;
  late MyDatabase db;
  DatabaseProvider({required this.db});
  var titleController = TextEditingController();
  var discriptionController = TextEditingController();
  List<NotesModel> data = [];
  Future<void> facthDataToGrid() async {
    data = await db.facthData();
    notifyListeners();
  }
  var currentDate =
      '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}';
  void addnotesToList(context) async {
    if (titleController.text.isNotEmpty &&
        discriptionController.text.isNotEmpty) {
      print('Notes added');
      db.createNotes(await NotesModel(
          modelId: 0,
          modelDate: currentDate,
          modelTitle: titleController.text.toString(),
          modelDescription: discriptionController.text.toString()));
      Navigator.pop(context);
      titleController.clear();
      discriptionController.clear();
      data = await db.facthData();
    }
    notifyListeners();
  }

  void deleteToList(int id, context) {
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
                    onPressed: () async {
                      db.deleteNotes(id);
                      Navigator.pop(context);
                      facthDataToGrid();
                    },
                    child: Text('Yes'))
              ],
            ));
    notifyListeners();
  }

  void addnotes(context, index) async {
    if (isUpdate == true) {
      var db = MyDatabase.instance;
      db.updateNotes(await NotesModel(
          modelId: data[index].modelId,
          modelDate: currentDate,
          modelTitle: titleController.text.toString(),
          modelDescription: discriptionController.text.toString()));
      Navigator.pop(context);
      titleController.text = '';
      discriptionController.text = '';
      data = await db.facthData();
    } else {
      if (titleController.text.isNotEmpty &&
          discriptionController.text.isNotEmpty) {
        print('Notes added');
        db.createNotes(await NotesModel(
            modelId: 0,
            modelDate: currentDate,
            modelTitle: titleController.text.toString(),
            modelDescription: discriptionController.text.toString()));
        Navigator.pop(context);
        titleController.clear();
        discriptionController.clear();
      }
      data = await db.facthData();
    }
    notifyListeners();
    facthDataToGrid();
  }

  void fieldValueToupdate(index) {}

  void fieldValueToNull() {
    titleController.text = '';
    discriptionController.text = '';
  }

  void navigatorToUpdatePage(context, mindex) {
    titleController.text = data[mindex].modelTitle.toString();
    discriptionController.text = data[mindex].modelDescription.toString();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddNotesScreens(
                  mindex: mindex,
                )));
  }

  // void updateToList(index, context) async {
  //   var db = MyDatabase.instance;
  //   db.updateNotes(await NotesModel(
  //       modelId: data[index].modelId,
  //       modelDate: currentDate,
  //       modelTitle: titleController.text.toString(),
  //       modelDescription: discriptionController.text.toString()));
  //   Navigator.pop(context);
  // }
}
