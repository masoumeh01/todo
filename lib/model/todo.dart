import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String task;
  final String description;
  bool? isCompleted;
  bool? isConcelled;

  Todo(
      {required this.id,
      required this.task,
      required this.description,
      this.isCompleted,
      this.isConcelled}) {
    isCompleted = isCompleted ?? false;
    isConcelled = isConcelled ?? false;
  }
  Todo copyWhit({
    String? id,
    String? task,
    String? description,
    bool? isCompleted,
    bool? isConcelled,
  }) {
    return Todo(
        id: id ?? this.id,
        task: task ?? this.task,
        description: description ?? this.description,
        isCompleted: isCompleted ?? this.isCompleted,
        isConcelled: isCompleted ?? this.isConcelled);
  }

  @override
  List<Object?> get props => [id,task,description,isConcelled,isConcelled];
  static List<Todo> todos=[
    Todo(id: '1', task: 'Learning java', description: 'Practis that'),
    Todo(id: '2', task: 'Learning dart', description: 'Practis that'),
  ];
}
