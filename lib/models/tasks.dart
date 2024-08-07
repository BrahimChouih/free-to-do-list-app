class Task {
  int id, priority;
  String task, description;
  int completed;
  Task(this.task, this.priority, this.completed, this.description);
  Task.toMAP(Map map){
    getMap(map);
  }
  Task.withId(
      this.id, this.task, this.priority, this.completed, this.description);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "id": this.id,
      "task": this.task,
      "priority": this.priority,
      "completed": this.completed,
      'description': this.description,
    };
    return map;
  }

  void getMap(Map<String, dynamic> map) {
    this.id = map["id"];
    this.task = map["task"];
    this.priority = map["priority"];
    this.completed = map["completed"];
    this.description = map['description'];
  }
}
