import 'package:flutter/material.dart';
import 'package:todo_list/data/models/todo_tile.dart';
import 'package:todo_list/data/remote/firebase_database.dart';
import 'package:todo_list/screens/loading.dart';

class CheckBoxList extends StatefulWidget {
  const CheckBoxList({Key? key}) : super(key: key);

  @override
  _CheckBoxListState createState() => _CheckBoxListState();
}

class _CheckBoxListState extends State<CheckBoxList> {
  final _databaseSource = FirebaseDatabase();
  bool loading = false;
  List<TodoTile> tiles = [];

  Future loadToDoTiles(String myUID) async {
    setState(() {
      loading = true;
    });
    var res = await _databaseSource.getToDoTiles(myUID);
    setState(() {
      loading = false;
    });
    if (res.docs.isNotEmpty) {
      for (int i = 0; i < res.docs.length; i++) {
        tiles.add((TodoTile.fromSnapshot(res.docs[i])));
      }

      return tiles;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : ListView.builder(
            itemCount: tiles.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Container(),
                ),
              );
            });
  }
}
