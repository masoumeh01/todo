import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_bloc/model/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoding()) {
    on<LoadTodo>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  void _onLoadTodos(LoadTodo event, Emitter<TodoState> emit) {
    emit(TodoLoded(todos: event.todos));
  }

  void _onAddTodo(AddTodo event, Emitter<TodoState> emit) {
    final state = this.state;
    if (state is TodoLoded) {
      emit(TodoLoded(todos: List.from(state.todos)..add(event.todo)));
    }
  }

  void _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) {
    final state =this.state;

    if(state is TodoLoded){
      List<Todo> todos=(state.todos.map((todo){
        return todo.id==event.todo.id ? event.todo :todo;
      } )).toList();
      
      emit(TodoLoded(todos: todos));
    }
  }
  void _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) {
    final state = this.state;
    if (state is TodoLoded) {
      List<Todo> todos = state.todos.where((todo) {
        return todo.id != event.todo.id;
      }).toList();

      emit(TodoLoded(todos: todos));
    }
  }
}
