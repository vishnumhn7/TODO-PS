import 'package:shared_preferences/shared_preferences.dart';

class DataManager {
  String listKey = "TodoTasks";

  // Stores the TODOList in Shared preference
  Future storeTodoList(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(listKey, list);
  }

  // Fetch the TODOList from Shared preference
  Future<List<String>> getTodoList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(listKey) ?? [];
  }
}