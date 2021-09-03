import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/data/models/todo_tile.dart';
import 'package:todo_list/data/remote/firebase_auth.dart';
import 'package:todo_list/data/remote/firebase_database.dart';
import 'package:todo_list/screens/loading.dart';
import 'package:todo_list/screens/login.dart';
import 'package:todo_list/widgets/checkbox_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = TextEditingController();
  bool loading = false;
  final _databaseSource = FirebaseDatabase();
  final _auth = FirebaseAuthSource();
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  late String _content;

  @override
  void initState() {
    super.initState();
    controller.addListener(() => setState(() {}));
  }

  String getTileUID() {
    return _auth.instance.currentUser!.uid + _content.hashCode.toString();
  }

  void onPost() {
    TodoTile tile = TodoTile(_content, getTileUID(), false);
    _databaseSource.addTodoTile(tile, _auth.instance.currentUser!.uid);
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()))),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: loading ? Loading() : const CheckBoxList(),
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                        hintText: 'What do you want To-Do?',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            controller.clear();
                          },
                        )),
                    onChanged: (val) => _content = val,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                    ),
                    ElevatedButton(
                      child: Text('P O S T'),
                      onPressed: onPost,
                    )
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ),
          )
        ],
      ),
    );
  }
}
