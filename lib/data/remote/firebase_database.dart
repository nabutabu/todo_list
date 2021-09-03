import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list/data/models/app_user.dart';
import 'package:todo_list/data/models/todo_tile.dart';

class FirebaseDatabase {
  final FirebaseFirestore instance = FirebaseFirestore.instance;

  void addTodoTile(TodoTile tile, String uid) {
    instance
        .collection('users')
        .doc(uid)
        .collection('tiles')
        .doc(tile.id)
        .set(tile.toMap());
  }

  void updateTodoTile(TodoTile tile, String uid) {
    instance
        .collection('users')
        .doc(uid)
        .collection('tiles')
        .doc(tile.id)
        .set(tile.toMap());
  }

  Future<QuerySnapshot> getToDoTiles(String uid) {
    return instance.collection('users').doc(uid).collection('tiles').get();
  }

  void addUser(AppUser user) {
    instance.collection('users').doc(user.id).set(user.toMap());
  }

  void updateUser(AppUser user) async {
    instance.collection('users').doc(user.id).update(user.toMap());
  }

  Future<DocumentSnapshot> getUser(String userId) {
    return instance.collection('users').doc(userId).get();
  }

  Stream<DocumentSnapshot> observeUser(String userId) {
    return instance.collection('users').doc(userId).snapshots();
  }
}
