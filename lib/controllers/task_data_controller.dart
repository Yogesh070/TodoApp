import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/model/task_model.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [
    // Task(
    //   title: 'Complete task and o',
    //   date: DateTime(2017, 9, 7, 17, 30),
    //   isDone: false,
    //   priority: 'low',
    //   description: 'Lorem dsaf aonfiuasu',
    // ),
    // Task(
    //   title: 'Complete task 1',
    //   date: DateTime(2017, 9, 7, 17, 30),
    //   isDone: false,
    //   priority: 'high',
    //   description: 'gg',
    // ),
    // Task(
    //   title: 'Complete task 2',
    //   date: DateTime(2017, 9, 7, 17, 30),
    //   isDone: true,
    //   priority: 'medium',
    //   description: 'gg,',
    // ),
    // Task(
    //   title: 'Complete task 3',
    //   date: DateTime(2017, 9, 7, 17, 30),
    //   isDone: false,
    //   priority: 'none',
    //   description: 'gg',
    // ),
  ];
  final List<Task> _pinnedTask = [];
  UnmodifiableListView<Task> get pinnedTask =>
      UnmodifiableListView(_pinnedTask);
  int get pinnedTaskCount => pinnedTask.length;

  int get taskCount => _tasks.length;
  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  void addTask(String taskTitle, taskDescription, taskPriority) {
    final newtask = Task(
      title: taskTitle,
      date: DateTime.now(),
      description: taskDescription,
      priority: taskPriority,
    );
    _tasks.insert(0, newtask);
    addToSharedPrference();
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    addToSharedPrference();

    notifyListeners();
  }

  void deleteTask(Task task) {
    task.isPinned! ? _pinnedTask.remove(task) : _tasks.remove(task);
    addToSharedPrference();

    notifyListeners();
  }

  void pinTask(Task task) {
    _tasks.remove(task);
    _pinnedTask.insert(0, task);

    task.tooglePin();
    addToSharedPrference();

    notifyListeners();
  }

  void unpinTask(Task task) {
    _pinnedTask.remove(task);
    _tasks.insert(0, task);
    task.tooglePin();
    addToSharedPrference();

    notifyListeners();
  }

  Future<void> getTodosFromSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    final initialTodos = prefs.getString('initialTodos');
    if (initialTodos == null) {
      _tasks = [];
    } else {
      _tasks = Task.decode(initialTodos);
    }
    notifyListeners();
  }

  void addToSharedPrference() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedTasks = Task.encode(_tasks);
    await prefs.setString('initialTodos', encodedTasks);
  }
}
