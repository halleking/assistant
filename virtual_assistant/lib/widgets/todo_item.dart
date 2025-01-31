import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/todo.dart';

class ToDoItem extends StatefulWidget {
  final DocumentSnapshot doc;
  final ToDo todo;
  final onToDoChanged;
  final onToDoEdited;
  final onDeleteItem;

  ToDoItem({
    Key? key, 
    required this.doc,
    required this.todo, 
    required this.onToDoChanged, 
    required this.onToDoEdited,
    required this.onDeleteItem
  }) : super(key: key);

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  bool _isEditMode = false;

  @override 
  Widget build(BuildContext context) {
    var textEditController = TextEditingController(text: widget.todo.todoText == null ? '' : widget.todo.todoText!);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
          onLongPress: () {
            setState(() {
              _isEditMode = true;
            });
          },
          onTap: () {
            widget.onToDoChanged(widget.todo, widget.doc);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          tileColor: Colors.white,
          leading: Icon(
            widget.todo.isDone ? Icons.check_box : Icons.check_box_outline_blank, 
            color: Colors.deepPurple,
            ),
          title: Container(
            child: (_isEditMode || widget.todo.todoText == null) ?
              TextFormField(
                controller: textEditController,
                autofocus: true,
                onTapOutside: ((event) {
                  _isEditMode = false;
                  FocusScope.of(context).unfocus();
                  widget.onToDoEdited(widget.todo, textEditController.text, widget.doc);
                }),
                onFieldSubmitted: (value) {
                  widget.todo.todoText = value;
                  _isEditMode = false;
                  FocusScope.of(context).unfocus();
                  widget.onToDoEdited(widget.todo, textEditController.text, widget.doc);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ) :
              Text(
                widget.todo.todoText!,
                style: TextStyle(
                    decoration: widget.todo.isDone ? TextDecoration.lineThrough : null,
                )
              )
          ),
          trailing: IconButton(
            onPressed: () {
              widget.onDeleteItem(widget.todo.id, widget.doc);
            },
            icon: Icon(Icons.close),
          )
          ),
        );
  }
}