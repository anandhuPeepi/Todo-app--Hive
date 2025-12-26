import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_crud/util/dialog_box.dart';
import 'package:hive_crud/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/database.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //reference the hive box
  final _myBox = Hive.box('mybox');

  toDoDataBase db = toDoDataBase();

  @override
  void initState() {
    //sds
    if (_myBox.get("TODOLIST") == null) {
      //create default data
      db.createInitialData();
    } else {
      //load the data from database
      db.loadData();
    }

    // TODO: implement initState
    super.initState();
  }

  final _textController = TextEditingController();

  //when check box tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
      _textController.clear();
    });
    db.updateDataBase();
  }

  //SAVE TASK
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_textController.text, false]);
    });
    Navigator.of(context).pop();
    db.updateDataBase();
    _textController.clear();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _textController,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTheTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 173, 145, 221),
      appBar: AppBar(title: Text("Todoo"), elevation: 0, centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask();
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskname: db.toDoList[index][0],
            taksCompleted: db.toDoList[index][1],
            onchanged: (value) => checkBoxChanged(value, index),
            deleteTask: (context) => deleteTheTask(index),
          );
        },
      ),
    );
  }
}
