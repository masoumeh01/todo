import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/bloc/todo_filter/todo_filter_bloc.dart';
import 'package:todo_bloc/model/todo.dart';
import 'package:todo_bloc/model/todo_filter.dart';
import 'package:todo_bloc/view/add_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => const AddScreen())));
                  },
                  icon: Icon(Icons.add)),
            ],
            bottom: TabBar(
              tabs: const [
                Tab(
                  icon: Icon(Icons.padding),
                ),
                Tab(
                  icon: Icon(Icons.add_task),
                )
              ],
              onTap: (tabindex) {
                switch (tabindex) {
                  case 0:
                    BlocProvider.of<TodoFilterBloc>(context)
                        .add(const UpdeteTodo(
                      todosFilter: TodosFilter.pending,
                    ));
                    break;
                  case 1:
                    BlocProvider.of<TodoFilterBloc>(context)
                        .add(const UpdeteTodo(
                      todosFilter: TodosFilter.completed,
                    ));
                }
              },
            ),
          ),
          body: TabBarView(
            children: [
              _todos('Pading to Dos'),
              _todos('Complated to Dos'),
            ],
          ),
        ));
  }

  BlocBuilder<TodoBloc, TodoState> _todos(String titel) {
    return BlocBuilder<TodoBloc, TodoState>(
        builder: ((context, state) {
      if (state is TodoLoding) {
        return CircularProgressIndicator();
      }
    if  (state is TodoLoded) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(titel),
              ),
              Container(
                height: 500,
                child: ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: ((context, index) {
                      return _todo(context, state.todos[index]);
                    })),
              ),
            ],
          ),
        );
      } else {
        return Text("Error");
      }
    }));
  }

  Card _todo(BuildContext context, Todo todo) {
    return Card(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            '${todo.id}:${todo.description}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    context.read<TodoBloc>().add(
                        UpdateTodo(todo: todo.copyWhit(isCompleted: true)));
                  },
                  icon: Icon(Icons.add_task)),
              IconButton(
                  onPressed: () {
                    context.read<TodoBloc>().add(DeleteTodo(todo: todo));
                  },
                  icon: Icon(Icons.cancel))
            ],
          )
        ]),
      ),
    );
  }
}
