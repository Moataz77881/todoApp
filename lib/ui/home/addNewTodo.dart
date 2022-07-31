import 'package:flutter/material.dart';
import 'package:todo_app/Data/fireStoreUtils.dart';


class addTodo extends StatefulWidget {

  @override
  State<addTodo> createState() => _addTodoState();
}

class _addTodoState extends State<addTodo> {
  var formKey = GlobalKey<FormState>();
  DateTime thisDay= DateTime.now();
  String Title='', description='';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Add new todo',textAlign: TextAlign.center,
          style:Theme.of(context).textTheme.headline2 ,
          ),
          Form( // to do validation the text field
            key: formKey,
              child:Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: Theme.of(context).textTheme.subtitle1
                    ),
                    validator: (textValue){
                      if(textValue == null || textValue.isEmpty){
                        return 'Please enter the todo title';
                      }else return null;
                    },
                    onChanged: (newTitle){
                      Title = newTitle;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: Theme.of(context).textTheme.subtitle1
                    ),
                    minLines: 4,
                    maxLines: 4,
                    validator: (description){
                      if(description==null||description.isEmpty)
                        return 'please enter the description';
                      else return null;
                    },
                    onChanged: (newdescription){
                      description = newdescription;
                    },
                  ),
                ],
              )
          ),
          Text('Date'),
          InkWell(
            onTap: (){
              showDate();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${thisDay.day}/${thisDay.month}/${thisDay.year}',textAlign: TextAlign.center,),
            ),
          ),
          ElevatedButton(onPressed: (){
            addTodoMethod();
          },
              child: Text('Add'))
        ],
      ),
    );
  }
  void addTodoMethod(){
   //1- get title and description
    // 2- selected date
    // create todo and add it in database
    if(! formKey.currentState!.validate())
      return;
    FireStoreTodoUtils.addTodoToFireStore(Title, description, thisDay).
    then( // todo added successfully
            (value) => Navigator.pop(context)) // When the todo has been added successfully, the bottom sheet will disappear
        .onError(
            (error, stackTrace) => print('Error adding todo'))
        .timeout(Duration(seconds: 10), onTimeout: (){
          print('cannot connect to server');
    });
  }

  void showDate() async{
    var selectedDatePiker = await showDatePicker( // a future date that the user will be selected
        context: context,
        initialDate: thisDay,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days:365))
    );
    if(selectedDatePiker!=null){
      thisDay= selectedDatePiker;
      setState(() {});
    }
  }
}
