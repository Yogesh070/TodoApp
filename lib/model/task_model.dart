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
}
