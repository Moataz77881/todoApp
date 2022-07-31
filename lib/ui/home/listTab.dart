import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/Data/fireStoreUtils.dart';
import 'package:todo_app/Data/todo.dart';
import 'package:todo_app/ui/home/todoWidget.dart';

class listTab extends StatefulWidget {

  @override
  State<listTab> createState() => _listTabState();
}

class _listTabState extends State<listTab> {
  DateTime selectedDay = DateTime.now();

  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          TableCalendar(
            selectedDayPredicate: (day){
              return isSameDay(selectedDay, day);
            },
            onDaySelected: (selDay, focDay){
              selectedDay = selDay;
              focusedDay = focDay;
              setState(() {});
            },
            calendarFormat: CalendarFormat.week,
              focusedDay: DateTime.now(),
              firstDay: DateTime.now()  //the first day that user can see
                  .subtract(Duration(days: 365)), // one year ago the user can see it
              lastDay: DateTime.now().add(Duration(days: 365)), // the last day that user can see
            calendarStyle: CalendarStyle(
              selectedTextStyle: TextStyle(
                color: Colors.white
              ),
              selectedDecoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
                todayTextStyle: TextStyle(
                  color: Colors.white
                ),
              todayDecoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              defaultDecoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              defaultTextStyle: TextStyle(
                color: Colors.black
              ),
              weekendTextStyle: TextStyle(
                color: Colors.black
              )
            ),
            weekendDays: [],
            daysOfWeekStyle: DaysOfWeekStyle(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    color: Colors.white
                ),
              weekdayStyle: TextStyle(
                color: Colors.black
              )
            ),
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot<Todo>>(  // state management using provider
                stream: FireStoreTodoUtils.addCollectionRefWithConverter().snapshots(),
                builder: (BuildContext buildContext, AsyncSnapshot<QuerySnapshot<Todo>> snapshot){
                  if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()));
                  }else if(snapshot.connectionState == ConnectionState.waiting){
                    //loading
                    return Center(child: CircularProgressIndicator());
                  }
                  // data is ready
                  List<Todo> todoItem = snapshot.data!.docs.map((docElement) => docElement.data()).toList();  // docs is an iteration of each todo
                  return ListView.builder(itemBuilder: (buildContext, index){
                    return todoWidget(todoItem[index]);
                  }, itemCount: todoItem.length,);
                  },
              )
          )
        ],
      ),
    );
  }
}
