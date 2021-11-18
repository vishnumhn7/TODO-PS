// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_app/datamanager.dart';
import 'package:todolist_app/main.dart';
import 'package:todolist_app/todolist_view.dart';
import 'package:todolist_app/todo_cubit.dart';

void main() {
  testWidgets('Todo List', (WidgetTester tester) async {

    final addButton = find.byKey(ValueKey("AddButton"));

    await tester.pumpWidget(MaterialApp(
        home: BlocProvider<TodoCubit>(
            create: (context) => TodoCubit(DataManager())..getTodoTasks(),
            child: TodoListView())));

    await tester.pumpAndSettle();
    await tester.tap(addButton);

    expect(find.byKey(ValueKey("AddButton")), findsOneWidget);

    /*//-----------
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget); */
  });
}
