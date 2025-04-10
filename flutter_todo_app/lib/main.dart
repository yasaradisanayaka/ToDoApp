import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo.dart';
import 'package:flutter_todo_app/widgets/todoItem.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoApp(),
    )
  );
}

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {

  final todos = Todo.toDoList();
  List<Todo> _searchTodo = [];

  TextEditingController todoController = TextEditingController();

  initState() {
    super.initState();
    setState(() {
      _searchTodo = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            IconButton(
              onPressed: () {}, 
              icon: Icon(
                Icons.menu
              ),
            ),

            CircleAvatar(
              backgroundImage: AssetImage(
                "assets/profile.jpg"
              ),
            )

          ],
        ),
      ),

      body: _body(),
    );
  }

  _body() {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchBar(),
            _todos(),
            _input()
          ],
        ),
      ],
    );
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextField(
            onChanged: (value) => search(value),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search",
              prefix: Icon(
                Icons.search,
                color: Colors.black,
              )
            ),
          ),
        ),
      ),
    );
  }

  _todos() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ALL TODOS"),
            Expanded(
              child: ListView(
                children: [
                  for(Todo todo in _searchTodo.reversed)
                  ToDoItem(
                    todo: todo, 
                    onDelete: () {
                      setState(() {
                        _searchTodo.remove(todo);
                      });
                    }, 
                    onClick: () {
                      setState(() {
                        todo.isDone=!todo.isDone;
                      });
                    }
                  )
                ],
              )
            )
          ],
        ),
      )
    );
  }

  _input() {
    return Align(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add new Todo",
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (todoController.text.trim().isEmpty) return; // Prevent empty todos
                  setState(() {
                    _searchTodo.add(
                      Todo(
                        //id: "17",
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: todoController.text
                      )
                    );
                    todoController.clear(); // Clear input field after adding
                  });
                }, 
                icon: Icon(
                  Icons.add
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  void search(String text) {
    List<Todo> result = [];
    
    if (text.isEmpty) {
      result = todos;
    }
    else {
      result = todos
        .where(
          (todo) => todo.title.toLowerCase().contains(
            text.toLowerCase()
          ))
        .toList();
    }
    setState(() {
      _searchTodo = result;
    });
  }
}