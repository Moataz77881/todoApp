import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/Data/todo.dart';

class FireStoreTodoUtils{
  static CollectionReference<Todo> addCollectionRefWithConverter(){
    return FirebaseFirestore.instance.
  collection(Todo.collectionName).withConverter<Todo>(
  fromFirestore: (firestoredata, _) => Todo.fromJson(firestoredata.data()!),
  toFirestore: (item, _) => item.toJson()
  );
} // to convert the todo data to json to write it in fire store and convert json map to todo item

  static Future<void> addTodoToFireStore(String title, String description, DateTime dateTime){
    
    CollectionReference<Todo> CollectionRef = addCollectionRefWithConverter();

    DocumentReference<Todo> docRef = CollectionRef.doc();
    Todo item = Todo(id: docRef.id,
        title: title,
        description: description,
        dateTime: dateTime);
    return CollectionRef.add(item);
  }

  static Future<void> deleteTodoWidget(Todo item){
    CollectionReference<Todo> CollectionRef = addCollectionRefWithConverter();
    DocumentReference<Todo> itemDoc = CollectionRef.doc(item.id);
    return itemDoc.delete();
  }

}