import 'dart:convert';

class Task {
  String? title;
  DateTime? date;
  String? priority;
  String? description;
  bool? isDone;
  bool? isPinned;
  Task({
    required this.title,
    this.date,
    this.priority,
    this.isDone = false,
    this.isPinned = false,
    this.description,
  });

  void toggleDone() {
    isDone = !isDone!;
  }

  void tooglePin() {
    isPinned = !isPinned!;
  }

  factory Task.fromJson(Map<String, dynamic> jsonData) {
    return Task(
      title: jsonData['title'],
      date: DateTime.parse(jsonData['date']),
      description: jsonData['description'],
      isDone: jsonData['isDone'],
      isPinned: jsonData['isPinned'],
      priority: jsonData['priority'],
    );
  }
  static Map<String, dynamic> toMap(Task task) => {
        'title': task.title,
        'description': task.description,
        'date': task.date!.toIso8601String(),
        'isDone': task.isDone,
        'isPinned': task.isPinned,
        'priority': task.priority
      };

  static String encode(List<Task> tasks) =>
      json.encode(tasks.map((task) => Task.toMap(task)).toList());

  static List<Task> decode(String tasks) =>
      (json.decode(tasks) as List<dynamic>)
          .map((e) => Task.fromJson(e))
          .toList();
}
