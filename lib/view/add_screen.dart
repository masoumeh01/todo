import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/model/todo.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerTask = TextEditingController();
    TextEditingController controllerDescription = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Add Task"),
      ),
      body: BlocListener<TodoBloc, TodoState>(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(9.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _inputFiled('Id', controllerId,),
                  _inputFiled('Task', controllerTask),
                  _inputFiled('Description', controllerDescription),
                  SizedBox(height: 10,),
                  ElevatedButton(
                      onPressed: () {
                        var todo = Todo(
                            id: controllerId.value.text,
                            task: controllerTask.value.text,
                            description: controllerDescription.value.text);
                            context.read<TodoBloc>().add(AddTodo(todo: todo));
                            Navigator.pop(context);
                           
                      },
                      child: const Text("Add Task")),
                ],
              ),
            ),
          ),
          listener: ((context, state) {
            if(state is TodoLoded){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("todo added")));
            }
          })),
    );
  }

  _inputFiled(String filed, TextEditingController controller) {
    return Column(
      
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$filed',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
        Container(
          margin: EdgeInsets.only(top:5),
          child: TextFormField(
            controller: controller,
          ),
        ),
      ],
    );
  }
}
