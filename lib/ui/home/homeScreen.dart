import 'package:flutter/material.dart';
import 'package:todo_app/ui/home/addNewTodo.dart';
import 'package:todo_app/ui/home/listTab.dart';
import 'package:todo_app/ui/home/settingsTab.dart';

class homeScreen extends StatefulWidget {
  static const String routName = 'homeScreen';

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  int currentTab=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Todo App'),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton( // blue circle in botton app bar
          elevation: 0,
          onPressed: () {
            showTodoActionSheet();
          },
          child: Icon(Icons.add),
          shape:
              StadiumBorder(side: BorderSide(color: Colors.white, width: 4))  // white circle in floating action button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: BottomNavigationBar(
          currentIndex: currentTab,
          onTap: (index){
            currentTab= index;
            setState(() {});    // setstate
          },
          items: [
            BottomNavigationBarItem(label: '', icon: Icon(Icons.list)),
            BottomNavigationBarItem(label: '', icon: Icon(Icons.settings))
          ],
        ),
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        notchMargin: 8, // space between floating action bar and button navigation bar
      ),
      body: Tabs[currentTab],
    );
  }
  List<Widget> Tabs = [
    listTab(),
    settingsTab()
  ];
  void showTodoActionSheet(){
    showModalBottomSheet(context: context,
        builder: (BuildContext){
      return addTodo();
    }
    );
  }
}
