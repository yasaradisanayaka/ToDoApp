import 'package:flutter/material.dart';
import 'package:flutter_todo_app/models/todo.dart';

class ToDoItem extends StatelessWidget {

  final Todo todo;
  final Function onDelete;
  final Function onClick;
  
  const ToDoItem(
    {super.key, 
    required this.todo, 
    required this.onDelete, 
    required this.onClick}
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),

        child: ListTile(
          onTap: () {
            onClick();
          },
          leading: Icon(
            todo.isDone
            ? Icons.check_box_outlined
            : Icons.check_box_outline_blank,
            color: Colors.white,
          ),
          title: Text(
            todo.title.toString(),
            style: TextStyle(
              color: Colors.white
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              onDelete();
            }, 
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}