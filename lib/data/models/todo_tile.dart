import 'package:cloud_firestore/cloud_firestore.dart';

class TodoTile {
  late String id;
  late String content;
  late bool isCompleted;

  TodoTile(this.content, this.id, this.isCompleted);

  TodoTile.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
    content = snapshot['content'];
    isCompleted = snapshot['isCompleted'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'isCompleted': isCompleted,
    };
  }
}
