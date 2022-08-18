import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/model/todo.dart';
import 'package:todo_bloc/model/todo_filter.dart';

part 'todo_filter_event.dart';
part 'todo_filter_state.dart';

class TodoFilterBloc extends Bloc<TodoFilterEvent, TodoFilterState> {
  final TodoBloc _todoBloc;
  late StreamSubscription _streamSubscription ;

  TodoFilterBloc({required TodoBloc todoBloc}) 
  
  :_todoBloc=todoBloc,
   super(TodoFilterLoding()) {
     on<UpdateFilter>(_onUpdateFilter);
   on<UpdeteTodo>(_onUpdateTodos);
   _streamSubscription=todoBloc.stream.listen((state) { 
     add( const UpdeteTodo());
   });
  }

  void _onUpdateFilter(UpdateFilter event ,Emitter<TodoFilterState> emit){
    if(state is TodoFilterLoding){
      add( const UpdeteTodo(todosFilter: TodosFilter.pending));
    }
    if( state is TodoFilterLodded){
      final state=this.state as TodoFilterLodded;
      add( UpdeteTodo (todosFilter:state.todosFilter));
    }
  }

void  _onUpdateTodos(UpdeteTodo event ,Emitter <TodoFilterState> emit){
  final state=_todoBloc.state;
  if(state is TodoLoded){

    List <Todo> todos=state.todos.where((todo){
        switch(event.todosFilter){
          case TodosFilter.all:
           return true;
          case TodosFilter.completed:
          return todo.isCompleted!;
          case TodosFilter.canceled:
          return todo.isConcelled!;
          case TodosFilter.pending:
          return !(todo.isConcelled! || todo.isCompleted!);

          
        }
    }).toList();
  }
}
  
}
