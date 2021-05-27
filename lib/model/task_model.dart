class Task {
  String? title;
  DateTime? date;
  String? priority;
  String? description;
  bool? isDone;
  Task({
    required this.title,
    this.date,
    this.priority,
    this.isDone = false,
    this.description,
  });

  void toggleDone() {
    isDone = !isDone!;
  }
}
