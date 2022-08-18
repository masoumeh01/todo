part of 'todo_filter_bloc.dart';

abstract class TodoFilterState extends Equatable {
  const TodoFilterState();

  @override
  List<Object> get props => [];
}

class TodoFilterLoding extends TodoFilterState {}

class TodoFilterLodded extends TodoFilterState {
  final List<Todo> filterstodos;
  final TodosFilter todosFilter;

 const TodoFilterLodded({required this.filterstodos, this.todosFilter = TodosFilter.all});
 @override
  List<Object> get props => [filterstodos,todosFilter];

}
