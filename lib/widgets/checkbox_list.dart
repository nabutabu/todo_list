import 'package:flutter/material.dart';
import 'package:todo_list/data/models/todo_tile.dart';
import 'package:todo_list/data/remote/firebase_auth.dart';
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
  final _auth = FirebaseAuthSource();
  List<TodoTile> tiles = [];

  void initState() {
    loadToDoTiles(_auth.instance.currentUser!.uid);
  }

  Future loadToDoTiles(String myUID) async {
    setState(() {
      loading = true;
    });
    var res = await _databaseSource.getToDoTiles(myUID);
    setState(() {
      loading = false;
    });
    if (res.docs.isNotEmpty) {
      print(res.docs.length.toString());
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
                  child: Container(
                    color: tiles[index].isCompleted ? Colors.grey[200] :
                      Colors.grey[300],
                    child: CheckboxListTile(
                      value: tiles[index].isCompleted ? false : true,
                      onChanged: (val) {
                        tiles[index].isCompleted = val!;
                        _databaseSource.updateTodoTile(tiles[index],
                            _auth.instance.currentUser!.uid);
                        setState(() {
                        });
                      },
                      title: Text(
                        tiles[index].content,
                        style: TextStyle(
                          color: tiles[index].isCompleted ? Colors.grey[800] :
                              Colors.grey[500],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
  }
}
