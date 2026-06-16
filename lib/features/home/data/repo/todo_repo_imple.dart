import 'package:dartz/dartz.dart';
import 'package:todo_list/core/utils/error/todo_errors.dart';
import 'package:todo_list/features/home/data/datasource/local_todo_data_source.dart';
import 'package:todo_list/features/home/data/models/todo_model.dart';
import 'package:todo_list/features/home/domain/repo/todo_repo.dart';

class TodoRepoImple extends TodoRepo {
  final LocalTodoDataSource _localTodoDataSource;

  TodoRepoImple({required LocalTodoDataSource localTodoDataSource})
    : _localTodoDataSource = localTodoDataSource;

  @override
  Future<Either<int, TodoAddingError>> addTodo({
    required String title,
    required String? subtitle,
    required DateTime whenToComplete,
    required DateTime createdAt,
  }) {
    return _localTodoDataSource.addTodo(
      title: title,
      subtitle: subtitle,
      whenToComplete: whenToComplete,
      createdAt: createdAt,
    );
  }

  @override
  Future<Either<void, TodoDeletionError>> deleteTodo(int id) {
    return _localTodoDataSource.deleteTodo(id);
  }

  @override
  Future<Either<List<TodoModel>, TodoRetrievalError>> getTodos() {
    return _localTodoDataSource.getTodos();
  }

  @override
  Future<Either<void, TodoUpdationError>> updateTodo({
    required int id,
    required String title,
    required String? subtitle,
    required DateTime whenToComplete,
    required bool isCompleted,
  }) {
    return _localTodoDataSource.updateTodo(
      id: id,
      title: title,
      subtitle: subtitle,
      whenToComplete: whenToComplete,
      isCompleted: isCompleted,
    );
  }
}
