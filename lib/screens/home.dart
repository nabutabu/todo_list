import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/data/models/todo_tile.dart';
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
  final _datebaseSource = FirebaseDatabase();
  final FirebaseFirestore instance = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    controller.addListener(() => setState(() {}));
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
              child: loading ? Loading() : CheckBoxList(),
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
                        hintText: 'enter..',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            controller.clear();
                          },
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                    ),
                    const ElevatedButton(
                      child: Text('P O S T'),
                      onPressed: null,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
