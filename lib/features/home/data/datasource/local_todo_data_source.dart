import 'package:dartz/dartz.dart';
import 'package:objectbox/objectbox.dart';
import 'package:todo_list/core/utils/error/todo_errors.dart';
import 'package:todo_list/features/home/data/models/todo_model.dart';
import 'package:todo_list/features/home/domain/entities/todo_object_box_model_entity.dart';
import 'package:todo_list/features/home/domain/repo/todo_repo.dart';

class LocalTodoDataSource implements TodoRepo {
  final Store store;
  late Box<TodoObjectBoxModelEntity> _box;
  LocalTodoDataSource({required this.store}) {
    _box = store.box<TodoObjectBoxModelEntity>();
  }

  @override
  Future<Either<int, TodoAddingError>> addTodo({
    required String title,
    required String? subtitle,
    required DateTime whenToComplete,
    required DateTime createdAt,
  }) async {
    try {
      final entity = await _box.putAndGetAsync(
        TodoObjectBoxModelEntity(
          title: title,
          whenToComplete: whenToComplete.toUtc().toIso8601String(),
          isCompleted: false,
          createdAt: createdAt.toUtc().toIso8601String(),
          subtitle: subtitle,
        ),
        mode: .insert,
      );

      return left(entity.id);
    } catch (e) {
      return right(TodoAddingError());
    }
  }

  @override
  Future<Either<void, TodoDeletionError>> deleteTodo(int id) async {
    try {
      _box.remove(id);
      return left(null);
    } catch (e) {
      return right(TodoDeletionError());
    }
  }

  @override
  Future<Either<List<TodoModel>, TodoRetrievalError>> getTodos() async {
    try {
      return left(
        _box.getAll().map((todo) {
          return TodoModel(
            id: todo.id,
            title: todo.title,
            subtitle: todo.subtitle,
            createdAt: DateTime.parse(todo.createdAt),
            isCompleted: todo.isCompleted,
            whenToComplete: DateTime.parse(todo.whenToComplete),
          );
        }).toList(),
      );
    } catch (e) {
      return right(TodoRetrievalError());
    }
  }

  @override
  Future<Either<void, TodoUpdationError>> updateTodo({
    required int id,
    required String title,
    required String? subtitle,
    required DateTime whenToComplete,
    required bool isCompleted,
  }) async {
    try {
      final prevTodo = _box.get(id);

      if (prevTodo == null) {
        return right(TodoUpdationError());
      }
      _box.put(
        TodoObjectBoxModelEntity(
          id: id,
          title: title,
          whenToComplete: whenToComplete.toUtc().toIso8601String(),
          isCompleted: isCompleted,
          createdAt: prevTodo.createdAt,
        ),
        mode: .update,
      );

      return left(null);
    } catch (e) {
      return right(TodoUpdationError());
    }
  }
}
