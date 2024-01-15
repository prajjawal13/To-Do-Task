import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_note_app_provider/widget/todo_list_widget.dart';
import 'package:provider/provider.dart';
import '../model/todo.dart';
import '../provider/todos.dart';
import '../widget/todo_form_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class AddTodoDialogWidget extends StatefulWidget {

  const AddTodoDialogWidget({Key? key}) : super(key: key);

  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();

}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  List<Todo> todoList=[];

  late SharedPreferences sharedPreferences;  

  @override
  void initState() {
    print("Init_called...");
    loadSharedPreferences();
    super.initState();
  }

  void loadSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  void loadData() async {
    List<String>? listString = sharedPreferences.getStringList('list');
    if (listString != null) {
      print("Loading Data.... $listString");
      setState(() {
         todoList=listString.map((item) => Todo.fromMap(json.decode(item))).toList();
      });
      Navigator.of(context).pop();
      print("Method Calling End...");
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Todo Task',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              TodoFormWidget(
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedDescription: (description) =>
                    setState(() => this.description = description),
                onSavedTodo:  
                addTodo,
                
              ),
            ],
          ),
        ),
      );

  void addTodo() {
   // showToast();
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      var todo=new Todo(title: title, description: description);
      final provider = Provider.of<TodosProvider>(context, listen: false);
      todoList.add(todo);
      provider.addTodo(todo);
      saveData();
    }
  }

  void saveData() {
    List<String> list =todoList.map((item) => jsonEncode(item.toMap())).toList();
    sharedPreferences.setStringList("list",list);
    loadData();
  }

  // void showToast() {  
  //   Fluttertoast.showToast(  
  //       msg: 'Data  Saved Sucessfully',  
  //       toastLength: Toast.LENGTH_SHORT,  
  //       gravity: ToastGravity.BOTTOM,    
  //       backgroundColor: Colors.grey,  
  //       textColor: Colors.black  
  //   );  
  // }  
}
