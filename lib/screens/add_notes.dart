// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:notes_app_with_database_and_provider/database/colors.dart';
// import 'package:notes_app_with_database_and_provider/database/model/notesmodel.dart';
import 'package:notes_app_with_database_and_provider/provider/databaseprovider.dart';
import 'package:provider/provider.dart';

class AddNotesScreens extends StatelessWidget {
  AddNotesScreens({super.key, this.mindex});
  var mindex;
  @override
  Widget build(BuildContext context) {
    // if(context.watch<DatabaseProvider>().isUpdate ==false){
    //   titleController.text ='';
    //   discriptionController.text ='';
    // }
    var mprovider = context.watch<DatabaseProvider>();
    // var rprovider = context.read<DatabaseProvider>();
    // if (mprovider.isUpdate != true) {

    // }
    return Scaffold(
      backgroundColor: uiColors.bgBlack,
      appBar: myaddnotesappbar(context, mindex),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            titleTextField(titleController: mprovider.titleController),
            discriptionTextField(contoller: mprovider.discriptionController),
          ],
        ),
      ),
    );
  }

  AppBar myaddnotesappbar(BuildContext context, index) {
    var wprovider = context.watch<DatabaseProvider>();
    var rprovider = context.read<DatabaseProvider>();
    return AppBar(
      title: Text('Add Notes'),
      foregroundColor: uiColors.greenShade,
      backgroundColor: uiColors.bgBlack,
      actions: [
        SizedBox(
          width: wprovider.isUpdate == true ? 110 : 90,
          height: 40,
          child: TextButton(
              onPressed: () {
                if (wprovider.isUpdate == true) {
                  rprovider.updateToList(index, context);
                  wprovider.fieldValueToupdate(mindex);
                  rprovider.fieldValueToNull(mindex);
                } else {
                  rprovider.addnotesToList(context);
                  rprovider.facthDataToGrid();
                  rprovider.fieldValueToNull(mindex);
                }
              },
              style: TextButton.styleFrom(
                  side: BorderSide(color: uiColors.greenShade),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: Text(
                wprovider.isUpdate == true ? 'Update' : "Save",
                style: TextStyle(
                  fontSize: 16,
                  color: uiColors.greenShade,
                ),
              )),
        ),
        SizedBox(width: 20)
      ],
    );
  }
}

class titleTextField extends StatelessWidget {
  const titleTextField({
    super.key,
    required this.titleController,
  });

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300),
      child: TextField(
        controller: titleController,
        maxLines: 5,
        minLines: 1,
        style: TextStyle(fontSize: 20, color: uiColors.white, letterSpacing: 1),
        decoration: InputDecoration(
            hintText: 'Title',
            hintStyle: TextStyle(
                letterSpacing: 1.8, fontSize: 20, color: uiColors.greenShade),
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }
}

class discriptionTextField extends StatelessWidget {
  discriptionTextField({super.key, required this.contoller});
  final TextEditingController contoller;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: contoller,
      maxLines: null,
      minLines: 1,
      style: TextStyle(fontSize: 18, color: uiColors.white, letterSpacing: 1),
      decoration: InputDecoration(
          hintText: 'Discription',
          hintStyle: TextStyle(
              letterSpacing: 1.8, fontSize: 18, color: uiColors.greenShade),
          border: OutlineInputBorder(borderSide: BorderSide.none)),
    );
  }
}

Column mytextfields() {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    SizedBox(
      width: 320,
      child: TextField(
        style: TextStyle(fontSize: 20, color: uiColors.white),
        cursorColor: uiColors.greenShade,
        decoration: notesTextfielDecoration("Title"),
      ),
    ),
    SizedBox(height: 10),
    SizedBox(
      width: 320,
      child: TextField(
        style: TextStyle(fontSize: 20, color: uiColors.white),
        cursorColor: uiColors.greenShade,
        decoration: notesTextfielDecoration('Discription'),
      ),
    ),
    SizedBox(height: 20),
    SizedBox(
        width: 140,
        child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              side: BorderSide(color: uiColors.white),
              foregroundColor: uiColors.white,
            ),
            child: Text(
              "Save",
              style: TextStyle(fontSize: 22),
            )))
  ]);
}

InputDecoration notesTextfielDecoration(hint) {
  return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(fontSize: 20, color: uiColors.white),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: uiColors.white)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: uiColors.Bordergreen, width: 3)));
}
