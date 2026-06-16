import 'package:flutter/material.dart';
import 'package:todo_list/features/home/data/models/todo_model.dart';
import 'package:todo_list/features/home/data/repo/todo_repo_imple.dart';

class TodoProvider extends ChangeNotifier {
  final TodoRepoImple todoRepoImple;

  TodoProvider({required this.todoRepoImple});

  List<TodoModel> _todos = [];
  bool _isRetrievalLoading = false;
  bool _isUpdationLoading = false;
  bool _isInsertionLoading = false;
  bool _isDeletionLoading = false;
  bool _hasRetrievalError = false;
  bool _todoInsertionSucceeded = false;
  bool _todoUpdationSucceeded = false;

  List<TodoModel> get todos => _todos;
  bool get isRetrievalLoading => _isRetrievalLoading;
  bool get isUpdationLoading => _isUpdationLoading;
  bool get isInsertionLoading => _isInsertionLoading;
  bool get isDeletionLoading => _isDeletionLoading;
  bool get hasRetrievalError => _hasRetrievalError;
  bool get todoInsertionSucceeded => _todoInsertionSucceeded;
  bool get todoUpdationSucceeded => _todoUpdationSucceeded;

  Future<void> addTodo({
    required String title,
    required String? subtitle,
    required DateTime whenToComplete,
    required DateTime createdAt,
    Function()? onSuccess,
    Function()? onFailure,
  }) async {
    _isInsertionLoading = true;
    _todoInsertionSucceeded = false;
    notifyListeners();
    final res = await todoRepoImple.addTodo(
      title: title,
      subtitle: subtitle,
      whenToComplete: whenToComplete,
      createdAt: createdAt,
    );

    _isInsertionLoading = false;

    res.fold(
      (id) {
        todos.add(
          TodoModel(
            id: id,
            title: title,
            subtitle: subtitle,
            createdAt: createdAt,
            isCompleted: false,
            whenToComplete: whenToComplete,
          ),
        );
        _todoInsertionSucceeded = true;
        notifyListeners();
      },
      (error) {
        _todoInsertionSucceeded = false;
        onFailure?.call();
        notifyListeners();
      },
    );

    _todoInsertionSucceeded = false;
    notifyListeners();
  }

  Future<void> deleteTodo({
    required int id,
    required int index,
    Function()? onSuccess,
    Function()? onFailure,
  }) async {
    _isDeletionLoading = true;

    notifyListeners();

    final res = await todoRepoImple.deleteTodo(id);

    res.fold(
      (_) {
        todos.removeAt(index);
        notifyListeners();
        onSuccess?.call();
      },
      (_) {
        onFailure?.call();
      },
    );
  }

  Future<void> updateTodo({
    required int id,
    required String title,
    required String? subtitle,
    required DateTime whenToComplete,
    required bool isCompleted,
    required int index,
    Function()? onSuccess,
    Function()? onFailure,
  }) async {
    _isUpdationLoading = true;
    _isUpdationLoading = false;
    notifyListeners();

    final res = await todoRepoImple.updateTodo(
      id: id,
      title: title,
      subtitle: subtitle,
      whenToComplete: whenToComplete,
      isCompleted: isCompleted,
    );

    if (res.isLeft()) {
      onSuccess?.call();

      todos[index] = todos[index].copyWith(
        isCompleted: isCompleted,
        subtitle: subtitle,
        title: title,
        whenToComplete: whenToComplete,
      );
      _isUpdationLoading = false;
      _todoUpdationSucceeded = true;
      notifyListeners();
    } else {
      onFailure?.call();
    }
    _todoUpdationSucceeded = false;
    notifyListeners();
  }

  Future<void> getTodos() async {
    _isRetrievalLoading = true;
    _hasRetrievalError = false;
    notifyListeners();

    final res = await todoRepoImple.getTodos();

    res.fold(
      (todos) {
        _todos = todos;
      },
      (error) {
        _hasRetrievalError = true;
      },
    );

    _isRetrievalLoading = false;
    notifyListeners();
  }
}
