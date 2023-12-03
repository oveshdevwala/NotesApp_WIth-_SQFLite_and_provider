import 'package:notes_app_with_database_and_provider/database/database.dart';

class NotesModel {
//variables
 int modelId;
  String modelDate;
  String modelTitle;
  String modelDescription;

//constructor
  NotesModel(
      {required this.modelId,
      required this.modelDate,
      required this.modelTitle,
      required this.modelDescription});

//from map to model
  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
        modelId: map[MyDatabase.colId],
        modelDate: map[MyDatabase.colDiscrption],
        modelTitle: map[MyDatabase.colTitle],
        modelDescription: map[MyDatabase.colDiscrption]);
  }
// model to map
  Map<String, dynamic> toMap() {
    return {
      MyDatabase.colDate: modelDate,
      MyDatabase.colTitle: modelTitle,
      MyDatabase.colDiscrption: modelDescription
    };
  }
}
