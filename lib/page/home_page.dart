import 'package:flutter/material.dart';
import '../main.dart';
import '../widget/add_todo_dialog_widget.dart';
import '../widget/todo_list_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
         appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 75, 10, 228),
          title: Padding(
            padding: EdgeInsets.only(top: 1, left: 1),
            child: Text(
              MyApp.title,
              style: TextStyle(
                  fontFamily: "Poppins",
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
          ),
         ),
         body: Center(
             child: TodoListWidget(),
         ),
        floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: Colors.white),
        backgroundColor: Color.fromARGB(255, 75, 10, 228),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddTodoDialogWidget(),
          barrierDismissible: false,
        ),
      ),
    );
  }
}



