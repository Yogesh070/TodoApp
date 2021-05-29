import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:todoapp/model/task_model.dart';

class TaskData extends ChangeNotifier {
  final List<Task> _tasks = [
    Task(
      title: 'Complete task and o',
      date: DateTime(2017, 9, 7, 17, 30),
      isDone: false,
      priority: 'low',
      description: 'Lorem dsaf aonfiuasu',
    ),
    Task(
      title: 'Complete task 1',
      date: DateTime(2017, 9, 7, 17, 30),
      isDone: false,
      priority: 'high',
      description: 'gg',
    ),
    Task(
      title: 'Complete task 2',
      date: DateTime(2017, 9, 7, 17, 30),
      isDone: true,
      priority: 'medium',
      description: 'gg,',
    ),
    Task(
      title: 'Complete task 3',
      date: DateTime(2017, 9, 7, 17, 30),
      isDone: false,
      priority: 'none',
      description: 'gg',
    ),
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
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void pinTask(Task task) {
    _tasks.remove(task);
    _pinnedTask.insert(0, task);

    task.tooglePin();
    notifyListeners();
  }

  void unpinTask(Task task) {
    _pinnedTask.remove(task);
    _tasks.insert(0, task);
    task.tooglePin();
    notifyListeners();
  }
}
