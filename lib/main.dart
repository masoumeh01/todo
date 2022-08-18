import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/bloc/todo_filter/todo_filter_bloc.dart';
import 'package:todo_bloc/model/todo.dart';
import 'package:todo_bloc/view/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen()),
      providers: [
        BlocProvider(
            create: (context) => TodoBloc()
              ..add(LoadTodo(
                todos: [
                  Todo(
                      id: '1',
                      task: 'Learning java',
                      description: 'Practis that'),
                  Todo(
                      id: '2',
                      task: 'Learning dart',
                      description: 'Practis that'),
                ],
              ))),
        BlocProvider(
          create: (context) => TodoFilterBloc(
            todoBloc: BlocProvider.of<TodoBloc>(context),
          ),
        ),
      ],
    );
  }
}
