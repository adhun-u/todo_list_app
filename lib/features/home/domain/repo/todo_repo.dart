import 'package:dartz/dartz.dart';
import 'package:todo_list/core/utils/error/todo_errors.dart';
import 'package:todo_list/features/home/data/models/todo_model.dart';

abstract class TodoRepo {
  Future<Either<int, TodoAddingError>> addTodo({
    required String title,
    required String? subtitle,
    required DateTime whenToComplete,
    required DateTime createdAt,
  });

  Future<Either<void, TodoDeletionError>> deleteTodo(int id);

  Future<Either<void, TodoUpdationError>> updateTodo({
    required int id,
    required String title,
    required String? subtitle,
    required DateTime whenToComplete,
    required bool isCompleted,
  });

  Future<Either<List<TodoModel>, TodoRetrievalError>> getTodos();
}
