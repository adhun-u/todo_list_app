import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/common/presentation/theme_provider.dart';
import 'package:todo_list/core/constants/app_assets.dart';
import 'package:todo_list/core/responsive/responsive.dart';
import 'package:todo_list/core/theme/app_colors.dart';
import 'package:todo_list/core/theme/app_theme.dart';
import 'package:todo_list/core/utils/helper/date_utils.dart';
import 'package:todo_list/core/utils/widgets/delete_dialog.dart';
import 'package:todo_list/features/home/data/models/todo_model.dart';
import 'package:todo_list/features/home/presentation/providers/todo_provider.dart';
import 'package:todo_list/features/home/presentation/screens/add_update_todo_screen.dart';

class TodoCard extends StatelessWidget {
  final TodoModel todo;
  final int index;
  const TodoCard({super.key, required this.todo, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, TodoProvider>(
      builder: (context, theme, todoProvider, _) {
        final isDark = theme.currentTheme == .dark;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: todo.isCompleted
                ? AppColors.greenColor.shade100
                : isDark
                ? AppTheme.darkCard
                : AppTheme.lightCard,
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        todo.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: .w600,
                          letterSpacing: -0.41,
                          color: todo.isCompleted ? AppTheme.darkPrimary : null,
                          decoration: todo.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          decorationThickness: 2.5,
                          decorationColor: AppTheme.darkPrimary,
                        ),
                      ),
                    ),
                    PopupMenuButton(
                      borderRadius: BorderRadius.circular(15),
                      enabled: !todo.isCompleted,
                      iconColor: todo.isCompleted ? AppTheme.darkPrimary : null,
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return DeleteDialog(
                                    onDeleteClicked: () {
                                      context.read<TodoProvider>().deleteTodo(
                                        id: todo.id,
                                        index: index,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Icon(Icons.delete),
                                const SizedBox(width: 5),
                                Text('Delete'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AddOrUpdateTodoScreen(
                                      index: index,
                                      toUpdateTodo: todo,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Icon(Icons.edit),
                                const SizedBox(width: 5),
                                Text('Update'),
                              ],
                            ),
                          ),
                        ];
                      },
                    ),
                  ],
                ),
                Text(
                  todo.subtitle == null ? "Not Specified" : todo.subtitle!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: .w400,
                    letterSpacing: -0.41,
                    color: todo.isCompleted ? AppTheme.darkPrimary : null,
                    decoration: todo.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                    decorationThickness: 2,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'When to complete: ${AppDateUtils.parseMMDDYYYY(todo.whenToComplete)}',
                  style: TextStyle(
                    color: todo.isCompleted ? AppTheme.darkPrimary : null,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Created at: ${AppDateUtils.parseMMDDYYYY(todo.createdAt)}',
                  style: TextStyle(
                    color: todo.isCompleted ? AppTheme.darkPrimary : null,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.maxFinite,

                  child: todo.isCompleted
                      ? Container(
                          height: 38,
                          decoration: BoxDecoration(
                            color: AppColors.greenColor.shade200,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: .center,
                            children: [
                              Image.asset(
                                AppAssets.checkFillIcon,
                                height: context.iconSize(20),
                                width: context.iconSize(20),
                                color: AppColors.greenColor,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Completed',
                                style: TextStyle(
                                  fontSize: context.fontSize(16),
                                  letterSpacing: -0.37,
                                  fontWeight: .w500,
                                  color: AppTheme.darkPrimary,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            context.read<TodoProvider>().updateTodo(
                              id: todo.id,
                              title: todo.title,
                              subtitle: todo.subtitle,
                              whenToComplete: todo.whenToComplete,
                              isCompleted: true,
                              index: index,
                            );
                          },
                          child: const Text('Mark as completed'),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
