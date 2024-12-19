class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo ({
    required this.id,
    required this.todoText,
    this.isDone = false,

  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '00', todoText: 'Item 00', isDone: true),
      ToDo(id: '01', todoText: 'Item 01', isDone: true),
      ToDo(id: '02', todoText: 'Item 02'),
      ToDo(id: '03', todoText: 'Item 03'),
      ToDo(id: '04', todoText: 'Item 04'),
    ];
  }

}