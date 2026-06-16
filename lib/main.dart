import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/common/presentation/theme_provider.dart';
import 'package:todo_list/core/theme/app_theme.dart';
import 'package:todo_list/features/home/data/datasource/local_todo_data_source.dart';
import 'package:todo_list/features/home/data/repo/todo_repo_imple.dart';
import 'package:todo_list/features/home/presentation/providers/todo_provider.dart';
import 'package:todo_list/features/home/presentation/screens/home_screen.dart';
import 'package:todo_list/objectbox.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory dir = await getApplicationDocumentsDirectory();
  final obxStore = await openStore(directory: "${dir.path}/todo");
  runApp(RootApp(store: obxStore));
}

class RootApp extends StatelessWidget {
  final Store store;
  const RootApp({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => TodoProvider(
            todoRepoImple: TodoRepoImple(
              localTodoDataSource: LocalTodoDataSource(store: store),
            ),
          ),
        ),
      ],
      builder: (context, _) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.currentTheme,
              home: const HomeScreen(),
            );
          },
        );
      },
    );
  }
}
