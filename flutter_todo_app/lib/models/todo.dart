class Todo{
  String id;
  String title;
  bool isDone;

  Todo({
    required this.id, 
    required this.title, 
    this.isDone = false
  });

  void isToggleDone() {
    isDone = !isDone;
  }

  static List<Todo> toDoList() {
    return [
      Todo(id: '1', title: 'Buy milk'),
      Todo(id: '2', title: 'Buy eggs', isDone: true),
      Todo(id: '3', title: 'Buy bread'),
    ];
  }
}