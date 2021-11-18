import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todolist_app/todo_cubit.dart';
import 'package:todolist_app/datamanager.dart';

class MockDataManager extends Mock implements DataManager {
  @override
  Future<List<String>> getTodoList() {
    return Future.value(["Task : getTodoList"]);
  }

  @override
  Future storeTodoList(List<String> list) {
    return Future.value(["Task : storeTodoList"]);
  }
}

void main() {
  TodoCubit todoCubit;
  MockDataManager mockDataManager;

  /*setUp(() {
    mockDataManager = MockDataManager();
    todoCubit = TodoCubit(mockDataManager);
  });

  tearDown(() {
    todoCubit.close();
  });*/

  test(
    'emits getTodoTasks when successful',
        () {
          mockDataManager = MockDataManager();
          todoCubit = TodoCubit(mockDataManager);
          todoCubit.getTodoTasks();
          expect() => [
            ["Task : getTodoList"]
          ];
    },
  );

  test(
    'emits saveTodoTasks when successful',
        () {
      mockDataManager = MockDataManager();
      todoCubit = TodoCubit(mockDataManager);
      todoCubit.saveTodoTasks(["Task 1"]);
      expect() => [["Task : saveTodoTasks"]];
    },
  );
}