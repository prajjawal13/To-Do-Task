import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../model/todo.dart';
import '../provider/todos.dart';
import '../widget/todo_form_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditTodoPage extends StatefulWidget {
  final Todo todo;
  List<Todo> todoList=[]; 

  EditTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  _EditTodoPageState createState() => _EditTodoPageState();

}

class _EditTodoPageState extends State<EditTodoPage> {

  late SharedPreferences sharedPreferences;
  final _formKey = GlobalKey<FormState>();
  List<Todo> todoList=[];
  
  String title = '';
  String description = '';

  @override
  void initState() {
    title = widget.todo.title;
    description = widget.todo.description;
    loadSharedPreferences();
    super.initState();
  }

   void loadSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void loadData() async {
    List<String>? listString = sharedPreferences.getStringList('list');
    if (listString != null) {
      print("Edit Loading Data.... $listString");
      setState(() {
         todoList=listString.map((item) => Todo.fromMap(json.decode(item))).toList();
      });
      Navigator.of(context).pop();
      print("Edit Method Calling End...");
    }
  }

   void saveData() {
    List<String> list =todoList.map((item) => jsonEncode(item.toMap())).toList();
    sharedPreferences.setStringList("list",list);
    loadData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 75, 10, 228),
          title: Padding(
            padding: EdgeInsets.only(top: 1, left: 1),
            child: Text(
              "Edit Todo Task",
              style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.white,
              onPressed: () {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);
                provider.removeTodo(widget.todo);

                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: TodoFormWidget(
              title: title,
              description: description,
              onChangedTitle: (title) => setState(() => this.title = title),
              onChangedDescription: (description) =>
                  setState(() => this.description = description),
              onSavedTodo: saveTodo,
            ),
          ),
        ),
      );

  void saveTodo() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    } else {
      var todo=new Todo(title: title, description: description);
      final provider = Provider.of<TodosProvider>(context, listen: false);
      todoList.add(todo);
      provider.updateTodo(widget.todo, title, description);
      saveData();
    }
  }
}





