// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:notes_app_with_database_and_provider/database/colors.dart';
import 'package:notes_app_with_database_and_provider/provider/databaseprovider.dart';
import 'package:provider/provider.dart';

class notesViewOntap extends StatelessWidget {
  notesViewOntap({super.key, required this.mindex});

  var mindex;
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<DatabaseProvider>();
    var rprovider = context.read<DatabaseProvider>();

    return Scaffold(
      backgroundColor: uiColors.bgBlack,
      appBar: AppBar(
        backgroundColor: uiColors.bgBlack,
        foregroundColor: uiColors.white,
        leading: Text(''),
        leadingWidth: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: uiColors.icongrey),
                icon: Icon(Icons.arrow_back_ios_new)),
            IconButton(
                onPressed: () {
                  rprovider.isUpdate = true;
                  provider.navigatorToUpdatePage(context, mindex);
                  provider.fieldValueToupdate(mindex);
                },
                style: TextButton.styleFrom(
                    backgroundColor: uiColors.icongrey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                icon: Icon(Icons.edit_document))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 10),
            Text(
              '${provider.data[mindex].modelTitle}',
              style: TextStyle(fontSize: 20, color: uiColors.white),
            ),
            SizedBox(height: 8),
            Text(provider.data[mindex].modelDate,
                style: TextStyle(fontSize: 14, color: uiColors.textGrey)),
            SizedBox(height: 8),
            Text(
              '${provider.data[mindex].modelDescription}',
              style: TextStyle(fontSize: 16, color: uiColors.white),
            ),
          ]),
        ),
      ),
    );
  }
}
