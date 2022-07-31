import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/Data/fireStoreUtils.dart';
import 'package:todo_app/Data/todo.dart';

class todoWidget extends StatefulWidget {

  Todo item;
  todoWidget(this.item);

  @override
  State<todoWidget> createState() => _todoWidgetState();
}

class _todoWidgetState extends State<todoWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      child: Container(
        color: Colors.red,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Container(
          color: Colors.white,
          child: Container(
            height: 120,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 62,
                  color: Theme.of(context).primaryColor,
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.item.title, style: Theme.of(context).textTheme.headline1,),
                          Text(widget.item.description, style: Theme.of(context).textTheme.subtitle1,),
                        ],
                      ),
                    )
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 6,
                    horizontal: 10
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child: Image.asset("assets/images/icon_check.png"),
                )
              ],
            ),
          ),
        ),
      ),
      actions: [
        IconSlideAction(
          color: Colors.transparent,
          iconWidget: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12)
              )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.delete, color: Colors.white,),
                Text('Delete', style: TextStyle(color: Colors.white),textAlign: TextAlign.center,)
              ],
            ),
          ),
          onTap:(){
            FireStoreTodoUtils.deleteTodoWidget(widget.item)
                .then((value){
              showMassage('Todo Deleted successfully');
            })
                .onError((error, stackTrace){
              showMassage(error.toString());
            }).
            timeout(Duration(seconds: 10),onTimeout: (){
              showMassage('timeout');
            });
          } ,
        )
      ],
    );
  }

  void showMassage(String Massage){
    showDialog(context: context, builder: (BuildContext){
      return AlertDialog(
        content: Text(Massage),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(BuildContext);
          }, child: Text('OK'))
        ],
      );
    });
  }
}
