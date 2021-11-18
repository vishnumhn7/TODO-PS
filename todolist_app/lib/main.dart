import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_app/datamanager.dart';
import 'package:todolist_app/todo_cubit.dart';
import 'todolist_view.dart';
import 'todo_cubit.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider<TodoCubit>(
            create: (context) => TodoCubit(DataManager())..getTodoTasks(), child: TodoListView()));
  }
}
