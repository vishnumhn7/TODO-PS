import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_app/datamanager.dart';

class TodoCubit extends Cubit<List<String>> {
  TodoCubit(this._dataManager) : super([]);

  final DataManager _dataManager;

  void getTodoTasks() async => emit(await _dataManager.getTodoList());
  void saveTodoTasks(List<String> list) async => emit(await _dataManager.storeTodoList(list));
}