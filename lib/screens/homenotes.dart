import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app_with_database_and_provider/database/colors.dart';
import 'package:notes_app_with_database_and_provider/provider/databaseprovider.dart';
import 'package:notes_app_with_database_and_provider/screens/add_notes.dart';
import 'package:notes_app_with_database_and_provider/screens/notesview.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<DatabaseProvider>().facthDataToGrid();
    print('Build Function called');
    var mprovider = context.read<DatabaseProvider>();
    return Scaffold(
        backgroundColor: uiColors.bgBlack,
        appBar: HomeAppbar(),
        floatingActionButton: addNoteButton(),
        body: SingleChildScrollView(
            child: Column(
          children: [
            mprovider.data.length != 0
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10),
                    itemCount: context.watch<DatabaseProvider>().data.length,
                    padding: EdgeInsets.all(12),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Consumer<DatabaseProvider>(
                          builder: (context, provider, child) {
                        print('Consumer called!!!!');
                        return InkWell(
                          splashColor: uiColors.greenShade,
                          borderRadius: BorderRadius.circular(25),
                          onLongPress: () async {
                            provider.deleteToList(
                                provider.data[index].modelId, context);
                            provider.facthDataToGrid();
                          },
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => notesViewOntap(
                                          mindex: index,
                                        )));
                          },
                          child: Container(
                            height: 250,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green,
                                    width: 5,
                                    strokeAlign: -0.5),
                                borderRadius: BorderRadius.circular(10),
                                color: uiColors.greenShade),
                            child: GridTile(
                              child: Text(
                                "${provider.data[index].modelTitle}",
                                style:
                                    TextStyle(overflow: TextOverflow.ellipsis),
                                maxLines: 4,
                              ),
                              footer: Text('${provider.data[index].modelDate}'),
                            ),
                          ),
                        );
                      });
                    })
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset('assets/lottie/emptyNotes.json'),
                        Text(
                          "Empty Notes",
                          style: TextStyle(fontSize: 20, color: uiColors.white),
                        ),
                        SizedBox(height: 100)
                      ],
                    ),
                  )
          ],
        )));
  }

  AppBar HomeAppbar() {
    return AppBar(
        backgroundColor: uiColors.bgBlack,
        foregroundColor: uiColors.white,
        title: Center(child: Text('Notes')));
  }
}

class addNoteButton extends StatelessWidget {
  const addNoteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read<DatabaseProvider>().isUpdate = false;
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddNotesScreens();
        }));
      },
      backgroundColor: uiColors.greenShade,
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: uiColors.Bordergreen, width: 5, strokeAlign: -0.5),
          borderRadius: BorderRadius.circular(20)),
      child: Icon(
        Icons.add,
        size: 35,
      ),
    );
  }
}
