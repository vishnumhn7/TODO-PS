import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_app/datamanager.dart';
import 'package:todolist_app/todo_cubit.dart';

class TodoListView extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoListView> {
  bool isEditing = false;

  List<String> _todoList = <String>[];
  final TextEditingController _textFieldController = TextEditingController();
  final todoCubit = TodoCubit(DataManager());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('ToDo List'),
      ),
      body: BlocBuilder<TodoCubit, List<String>>(
          // future: getStringList(),
          builder: (context, todoList) {
        _todoList = todoList;
        if (todoList.isEmpty)
          return Container(); // Display empty container if the list is empty
        else {
          return ListView.separated(
            shrinkWrap: true,
            key: ValueKey("todolistview"),
            itemCount: _todoList.length,
            itemBuilder: (context, index) {
              return ListTile(
                // onTap: () => _promptRemoveTodoItem(index),
                title: Text(_todoList[index].toString()),
                trailing: Wrap(
                  spacing: 12, // space between two icons
                  children: <Widget>[
                    FloatingActionButton.small(
                      backgroundColor: Colors.black,
                      onPressed: () {
                        isEditing = true;
                        _displayDialog(context, index: index);
                      },
                      child: Icon(Icons.edit),
                    ),
                    FloatingActionButton.extended(
                      label: Text('Mark done'),
                      backgroundColor: Colors.black,
                      onPressed: () {
                        _promptRemoveTodoItem(index);
                      },
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        key: ValueKey("AddButton"),
        backgroundColor: Colors.black,
        onPressed: () => _displayDialog(context),
        tooltip: 'Add Item',
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTodoItem(String title) {
    //Wrapping it inside a set state will notify
    // the app that the state has changed
    if (title.isNotEmpty) {
      setState(() {
        _todoList.add(title);
        todoCubit.saveTodoTasks(_todoList);
        // storeStringList(_todoList);
      });
      _textFieldController.clear();
    }
  }

  //Generate list of item widgets
  Widget _buildTodoItem(String title) {
    return ListTile(
      title: Text(title),
    );
  }

  void _promptRemoveTodoItem(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              key: ValueKey("MarkDoneDialogBox"),
              title: Text('Mark "${_todoList[index]}" as done?'),
              actions: <Widget>[
                FlatButton(
                    key: ValueKey("cancelbutton"),
                    child: Text('CANCEL'),
                    // The alert is actually part of the navigation stack, so to close it, we
                    // need to pop it.
                    onPressed: () => Navigator.of(context).pop()),
                FlatButton(
                    key: ValueKey("markasdone"),
                    child: Text('MARK AS DONE'),
                    onPressed: () {
                      setState(() {
                        _todoList.removeAt(index);
                        todoCubit.saveTodoTasks(_todoList);
                        // storeStringList(_todoList);
                      });
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }

  //Generate a single item widget
  void _displayDialog(BuildContext context, {int index = 0}) async {
    _textFieldController.text = isEditing ? _todoList[index] : '';
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            key: ValueKey("AddTaskDialogBox"),
            title: Text(isEditing ? 'Update your task' : 'Add a task to your List'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Enter task here'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(isEditing ? 'UPDATE' : 'ADD'),
                onPressed: () {
                  if (isEditing) {
                    setState(() {
                      _todoList[index] = _textFieldController.text;
                      todoCubit.saveTodoTasks(_todoList);
                      // storeStringList(_todoList);
                    });
                  } else {
                    _addTodoItem(_textFieldController.text);
                  }
                  Navigator.of(context).pop();
                  isEditing = false;
                },
              ),
              FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                  isEditing = false;
                },
              ),
            ],
          );
        });
  }
}
