import 'package:flutter/material.dart';
import 'package:to_do_app/elements/new_task_form.dart';
import 'package:to_do_app/elements/edit_task_form.dart';
import '../elements/tiles.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Todo class + builder
class Todo {
  dynamic id;
  String desc;
  bool complete;

  Todo(this.id, this.desc, this.complete);
}

class _HomePageState extends State<HomePage> {
  // text controller
  final _controller = TextEditingController();

  List<Todo> todoList = [];

  // save new task
  void saveNewTask() {
    setState(() {
      todoList.add(Todo(const Uuid(), _controller.text, false));
    });
    Navigator.of(context).pop();
    _controller.clear();
  }

  // save edited task
  void saveEditedTask() {
    setState(() {
      todoList[0].desc = _controller.text;
    });
    Navigator.of(context).pop();
    _controller.clear();
  }

  // edit task
  void editTask(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return EditBox(
            controller: _controller,
            onSave: saveEditedTask,
            onCancel: cancelTask,
          );
        });
  }

  // dismiss dialog
  void cancelTask() {
    Navigator.of(context).pop();
    _controller.clear();
  }

  // add tasks
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: cancelTask,
          );
        });
  }

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todoList[index].complete = !todoList[index].complete;
    });
  }

  // delete tasks
  void deleteTask(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Projet ToDoList Take Up'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: todoList[index].desc,
            taskCompleted: todoList[index].complete,
            onChanged: ((value) => checkBoxChanged(value, index)),
            deleteTask: (context) => deleteTask(index),
            editTask: (context) => editTask(index),
          );
        },
      ),
    );
  }
}
