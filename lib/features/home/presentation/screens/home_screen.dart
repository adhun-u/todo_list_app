import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/common/presentation/theme_provider.dart';
import 'package:todo_list/core/responsive/responsive.dart';
import 'package:todo_list/core/theme/app_theme.dart';
import 'package:todo_list/features/home/presentation/components/empty_todos_component.dart';
import 'package:todo_list/features/home/presentation/components/todo_card.dart';
import 'package:todo_list/features/home/presentation/providers/todo_provider.dart';
import 'package:todo_list/features/home/presentation/screens/add_update_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoProvider>().getTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          leadingWidth: context.dWidth * 0.3,
          leading: Center(
            child: Text(
              'My Tasks',
              style: TextStyle(
                fontSize: context.fontSize(18),
                fontWeight: .w600,
                letterSpacing: -0.41,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                final read = context.read<ThemeProvider>();
                read.changeTheme();
              },
              icon: Consumer<ThemeProvider>(
                builder: (context, themeProvider, _) {
                  return themeProvider.currentTheme == .dark
                      ? const Icon(Icons.light_mode)
                      : const Icon(Icons.dark_mode);
                },
              ),
            ),
          ],
        ),

        body: Consumer<TodoProvider>(
          builder: (context, todosProvider, _) {
            final todos = todosProvider.todos;
            final todosLoading = todosProvider.isRetrievalLoading;
            return todosLoading
                ? Center(
                    child: Consumer<ThemeProvider>(
                      builder: (context, theme, _) {
                        return CircularProgressIndicator(
                          color: theme.currentTheme == .dark
                              ? AppTheme.lightPrimary
                              : AppTheme.darkPrimary,
                        );
                      },
                    ),
                  )
                : todos.isEmpty
                ? const EmptyTodosComponent()
                : ListView.separated(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: index == 0 ? 10 : 0,
                          bottom: index == todos.length - 1 ? 10 : 0,
                        ),
                        child: TodoCard(todo: todo, index: index),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                  );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const AddOrUpdateTodoScreen();
                },
              ),
            );
          },
          shape: const CircleBorder(),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
