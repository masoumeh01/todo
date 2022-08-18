part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
  
  @override
  List<Object> get props => [];
}

class TodoLoding extends TodoState {}
class TodoLoded extends TodoState {
  final List<Todo> todos;
  
  const TodoLoded({this.todos = const<Todo>[]});
   @override
  List<Object> get props => [todos];

}
