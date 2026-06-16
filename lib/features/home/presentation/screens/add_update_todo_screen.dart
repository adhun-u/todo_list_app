import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/core/common/presentation/theme_provider.dart';
import 'package:todo_list/core/constants/app_assets.dart';
import 'package:todo_list/core/responsive/responsive.dart';
import 'package:todo_list/core/theme/app_colors.dart';
import 'package:todo_list/core/theme/app_theme.dart';
import 'package:todo_list/core/utils/helper/date_utils.dart';
import 'package:todo_list/core/utils/widgets/custom_text_field.dart';
import 'package:todo_list/features/home/data/models/todo_model.dart';
import 'package:todo_list/features/home/presentation/providers/todo_provider.dart';

class AddOrUpdateTodoScreen extends StatefulWidget {
  final TodoModel? toUpdateTodo;
  final int? index;
  const AddOrUpdateTodoScreen({super.key, this.toUpdateTodo, this.index});

  @override
  State<AddOrUpdateTodoScreen> createState() => _AddOrUpdateTodoScreenState();
}

class _AddOrUpdateTodoScreenState extends State<AddOrUpdateTodoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();

  late ValueNotifier<DateTime?> _whenToComplete;

  late final TodoProvider _provider = context.read<TodoProvider>();

  void _popScreen() {
    if (_provider.todoInsertionSucceeded || _provider.todoUpdationSucceeded) {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    _whenToComplete = ValueNotifier(widget.toUpdateTodo?.whenToComplete);
    _titleController.text = widget.toUpdateTodo?.title ?? "";
    _subtitleController.text = widget.toUpdateTodo?.subtitle ?? "";

    _provider.addListener(_popScreen);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    _whenToComplete.dispose();
    _provider.removeListener(_popScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          elevation: 0,
          leadingWidth: context.dWidth * 0.32,

          leading: Row(
            crossAxisAlignment: .center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back),
              ),
              Text(
                'Add Todo',
                style: TextStyle(
                  fontSize: context.fontSize(18),
                  fontWeight: .w600,
                  letterSpacing: -0.41,
                ),
              ),
            ],
          ),
        ),

        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: CustomTextField(
                        hintText: 'Enter the title for todo',
                        controller: _titleController,
                        maxLength: 100,
                        title: 'Title',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: CustomTextField(
                        hintText: 'Enter the subtitle for todo',
                        controller: _subtitleController,
                        maxLength: 500,
                        maxLines: 5,
                        title: 'Subtitle',
                      ),
                    ),
                    Padding(
                      padding: .symmetric(horizontal: 16, vertical: 20),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Align(
                            alignment: .topLeft,
                            child: Text(
                              'When to complete',
                              style: TextStyle(
                                fontSize: context.fontSize(16),
                                letterSpacing: -0.37,
                                fontWeight: .w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: GestureDetector(
                              onTap: () async {
                                final pickedDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  initialDate: DateTime.now(),
                                  lastDate: DateTime.now().add(
                                    Duration(days: 365 * 100),
                                  ),
                                );

                                if (pickedDate != null) {
                                  _whenToComplete.value = pickedDate;
                                }
                              },
                              child: Container(
                                height: 48,
                                width: context.dWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: context.colorScheme.secondary,
                                ),
                                child: Row(
                                  mainAxisAlignment: .center,
                                  children: [
                                    ValueListenableBuilder(
                                      valueListenable: _whenToComplete,
                                      builder: (context, date, _) {
                                        return Image.asset(
                                          AppAssets.checkFillIcon,
                                          height: context.iconSize(20),
                                          width: context.iconSize(20),
                                          color: date == null
                                              ? AppColors.greyColor
                                              : AppColors.greenColor,
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 5),
                                    ValueListenableBuilder(
                                      valueListenable: _whenToComplete,
                                      builder: (context, date, _) {
                                        return Text(
                                          date == null
                                              ? 'Not Selected'
                                              : AppDateUtils.parseMMDDYYYY(
                                                  date,
                                                ),
                                          style: TextStyle(
                                            fontSize: context.fontSize(16),
                                            letterSpacing: -0.37,
                                            fontWeight: .w500,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: .symmetric(horizontal: 16, vertical: 20),
              child: ElevatedButton(
                onPressed: () {
                  final read = context.read<TodoProvider>();

                  if (read.isInsertionLoading) {
                    return;
                  }

                  final String title = _titleController.text.trim();
                  final String subtitle = _subtitleController.text.trim();

                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  if (title.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Title is required !!')),
                    );
                  } else if (_whenToComplete.value == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Select a date for showing when to complete !!',
                        ),
                      ),
                    );
                  } else {
                    if (widget.toUpdateTodo != null) {
                      read.updateTodo(
                        id: widget.toUpdateTodo!.id,
                        title: title,
                        subtitle: subtitle,
                        whenToComplete: _whenToComplete.value!,
                        isCompleted: false,
                        index: widget.index!,
                      );
                    } else {
                      read.addTodo(
                        title: title,
                        subtitle: subtitle,
                        whenToComplete: _whenToComplete.value!,
                        createdAt: DateTime.now(),
                      );
                    }
                  }
                },
                child: SizedBox(
                  height: 48,
                  child: Consumer<TodoProvider>(
                    builder: (context, todoProvider, _) {
                      return Center(
                        child:
                            todoProvider.isInsertionLoading ||
                                todoProvider.isUpdationLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: Consumer<ThemeProvider>(
                                  builder: (context, theme, _) {
                                    return CircularProgressIndicator(
                                      color: theme.currentTheme == .dark
                                          ? AppTheme.darkPrimary
                                          : AppTheme.lightPrimary,
                                      strokeWidth: 1,
                                    );
                                  },
                                ),
                              )
                            : const Text('Save Task'),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
